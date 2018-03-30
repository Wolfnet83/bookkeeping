class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @current_accounts = current_user.accounts.not_deposit.order(:name)
    @deposit_accounts = current_user.accounts.deposit.order(:name)
    calculate_accounts
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
    @planned_fees = current_user.planned_fees.unpaid
    @calculated_planned_fees_amount  = 0
    @planned_fees.each do |planned_fee|
      @calculated_planned_fees_amount += planned_fee.currency.default_currency? ? planned_fee.amount : planned_fee.amount_in_dc
    end
  end

  def calculate_accounts
    @current_accounts_funds = 0
    @current_accounts.each do |account|
      @current_accounts_funds += account.currency.default_currency? ? account.funds : account.funds_in_dc
    end
  end
end
