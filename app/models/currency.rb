class Currency < ActiveRecord::Base
  validates :name, :abbr_name, presence: true
  validates :default_currency, uniqueness: true, if: :default_currency

  has_many :accounts

  def self.get_exchange_rates
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
    Currency.all.each do |cur|
      cur.exchange_rate = cur_hash[cur.abbr_name] if cur_hash[cur.abbr_name].present?
      cur.save!
    end
    Account.calculate_accounts_in_default_currency
  end

  def self.default_currency
    Currency.where(default_currency: :true).first
  end

end
