class ReportsController < ApplicationController
  def top_categories
    if params[:date].present?
      @date = "#{params[:date][:month]}/#{params[:date][:year]}".to_date
      @categories = Transaction.select('category_id as cat, sum(amount) as am, sum(amount_in_dc) as am_in_dc')
                             .joins(:category)
                             .where("categories.category_type <> ?", INCOME)
                             .group(:category_id)
                             .order("sum(amount_in_dc) desc")
                             .in_date(@date)
    else
      @date = Date.today.beginning_of_month
      @categories = Transaction.select('category_id as cat, sum(amount) as am, sum(amount_in_dc) as am_in_dc')
                             .joins(:category)
                             .where("categories.category_type <> ?", INCOME)
                             .group(:category_id)
                             .order("sum(amount_in_dc) desc")
                             .in_current_month
    end
  end
  def top_categories_by_year
    if params[:date].present?
      @date = "01/#{params[:date][:year]}".to_date
    else
      @date = Date.today.beginning_of_year
    end
      @categories = Transaction.select('category_id as cat, sum(amount) as am, sum(amount_in_dc) as am_in_dc')
                           .joins(:category)
                           .where("categories.category_type <> ?", INCOME)
                           .group(:category_id)
                           .order("sum(amount_in_dc) desc")
                           .in_year(@date)
  end
end
