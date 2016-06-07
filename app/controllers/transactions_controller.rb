class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_transaction, only: [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    if params[:date].present?
      @date = "#{params[:date][:month]}/#{params[:date][:year]}".to_date
    else
      @date = Date.today.beginning_of_month
    end
    @transactions = current_user.transactions.where(nil)
    filtering_params(params).each do |key, value|
      @transactions = @transactions.public_send(key, value) if value.present?
    end
    @transactions = @transactions.in_date(@date)
    @transactions = @transactions.order(sort_column + ' ' + sort_direction)
  end

  def show
  end

  def edit
  end

  def update
    if @transaction.update_attributes(permitted_params)
      redirect_to transactions_path, notice: t('transaction.updated')
    else
      render "edit"
    end
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction= current_user.transactions.new(permitted_params)
    if @transaction.valid?
      @transaction.save!
      redirect_to transactions_path
    else
      render "new"
    end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_path, notice: t('transaction.deleted')
  end

  private
  def find_transaction
    @transaction = current_user.transactions.find_by_id(params[:id])
  end

  def permitted_params
    params[:transaction].permit(:account_id, :category_id, :amount, :comment, :created_at)
  end

  def sort_column
    Transaction.column_names.include?(params[:sort_by]) ? params[:sort_by] : 'created_at, id'
  end

  def sort_direction
    %w[asc desc].include?(params[:dir]) ? params[:dir] : 'asc'
  end

  def filtering_params(params)
    params.slice(:account, :category)
  end
end
