class TransfersController < ApplicationController
  before_action :find_transfer, only: [:destroy]
  helper_method :sort_column, :sort_direction

  def index
    if params[:date].present?
      @date = "#{params[:date][:month]}/#{params[:date][:year]}".to_date
    else
      @date = Date.today.beginning_of_month
    end
    @transfers = current_user.transfers.where(nil)
    filtering_params(params).each do |key, value|
      @transfers = @transfers.public_send(key, value) if value.present?
    end
    @transfers = @transfers.in_date(@date)
    @transfers = @transfers.order(sort_column + ' ' + sort_direction)
  end

  def new
    @transfer = Transfer.new
  end

  def create
    @transfer= current_user.transfers.new(permitted_params)
    if @transfer.valid?
      @transfer.save
      redirect_to transfers_path
    else
      render "new"
    end
  end

  def destroy
    if @transfer.valid?
      @transfer.destroy
      redirect_to transfers_path, notice: t('transfer.deleted')
    else
      redirect_to transfers_path, notice: t('account.doesnt_enough_money')
    end
  end

  private
  def find_transfer
    @transfer = current_user.transfers.find_by_id(params[:id])
  end

  def permitted_params
    params[:transfer].permit(:from_account_id, :to_account_id, :amount)
  end

  def sort_column
    Transfer.column_names.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:dir]) ? params[:dir] : 'asc'
  end

  def filtering_params(params)
    params.slice(:from_account, :to_account)
  end
end
