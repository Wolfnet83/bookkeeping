class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = current_user.accounts.all
    calculate_top_categories
    get_exchange_rates
  end

  private
  def calculate_top_categories
    @categories = Transaction.select('category_id as cat, sum(amount) as am')
                             .joins(:category)
                             .where("categories.category_type <> ?", INCOME)
                             .in_current_month.group(:category_id)
                             .order("sum(amount) desc")
                             .limit(10)
  end

  def get_exchange_rates
    require 'open-uri'
    date = Date.today.strftime('%d.%m.%Y')
    cur_hash = {}
    doc = Nokogiri::XML(open("http://www.bnm.md/en/official_exchange_rates?get_xml=1&date=#{date}"))
    doc.xpath("//Valute").each do |valute|
      cur_code = valute.search("CharCode").text
      cur_name = valute.search("Name").text
      cur_value = valute.search("Value").text
      cur_hash.merge!(Hash[cur_code, cur_value])
    end
  end
end
