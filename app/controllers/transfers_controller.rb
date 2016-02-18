class TransfersController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    @transfers = current_user.transfers.all
  end

  def new
    @transfer = Transfer.new
    @accounts = current_user.accounts.all
  end

  def create
    @transfer= current_user.transfers.new(permitted_params)
    if @transfer.valid?
      @transfer.save
      redirect_to transfers_path
    else
      flash[:error] = @transfer.errors.full_messages
      render "new"
    end
  end

  private
  def permitted_params
    params[:transfer].permit(:from_account_id, :to_account_id, :amount)
  end

  def sort_column
    Transfer.column_names.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:dir]) ? params[:dir] : 'asc'
  end
end
