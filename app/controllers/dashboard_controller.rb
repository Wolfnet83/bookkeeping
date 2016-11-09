class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = current_user.accounts.all
    calculate_top_categories
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
end
