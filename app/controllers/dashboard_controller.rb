class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = current_user.accounts.order(:name)
    calculate_top_categories
    calculate_planned_fees
  end

  private
  def calculate_top_categories
    @categories = Transaction.select('category_id as cat, sum(amount_in_dc) as am')
                             .joins(:category)
                             .where("categories.category_type <> ?", INCOME)
                             .in_current_month.group(:category_id)
                             .order("sum(amount_in_dc) desc")
                             .limit(10)
  end

  def calculate_planned_fees
    @planned_fees = current_user.planned_fees.this_month.unpaid
    @calculated_planned_fees_amount  = 0
    @planned_fees.each do |planned_fee|
      @calculated_planned_fees_amount += planned_fee.currency.default_currency? ? planned_fee.amount : planned_fee.amount_in_dc
    end
  end
end
