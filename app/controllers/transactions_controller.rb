class TransactionsController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    if params[:filter].blank?
      @transactions = current_user.transactions.in_current_month.order(sort_column + ' ' + sort_direction)
    else
      date = "#{params[:date][:month]}/#{params[:date][:year]}".to_date
      filter_hash = { account: params[:account],
                      category: params[:category] }
      filter_hash.reject! {|_, v| v.empty?}
      filter_hash.merge!({created_at: date..date.end_of_month})
      @transactions = current_user.transactions.where(filter_hash)
    end
  end

  def show
  end

  def edit
    @transaction = current_user.transactions.find_by_id(params[:id])
  end

  def update
    @transaction = current_user.transactions.find_by_id(params[:id])
    if @transaction.update_attributes(permitted_params)
      redirect_to transactions_path, notice: "Transaction updated successfully"
    else
      flash[:error] = "Transaction doesn't updated"
      render "edit"
    end
  end

  def new
    @transaction = Transaction.new
    @categories  = current_user.categories.all
    @accounts    = current_user.accounts.all
  end

  def create
    @transaction= current_user.transactions.new(permitted_params)
    @categories  = current_user.categories.all
    @accounts    = current_user.accounts.all
    if @transaction.valid?
      @transaction.save
      redirect_to transactions_path
    else
      flash[:error] = @transaction.errors.full_messages
      render "new"
    end
  end

  def destroy
    @transaction = current_user.transactions.find_by_id(params[:id])
    @transaction.destroy
    redirect_to transactions_path, notice: "Category successfully deleted"
  end

  private
  def permitted_params
    params[:transaction].permit(:account_id, :category_id, :amount, :comment, :created_at)
  end

  def sort_column
    Transaction.column_names.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:dir]) ? params[:dir] : 'asc'
  end
end
