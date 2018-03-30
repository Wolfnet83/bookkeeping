class PlannedFeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @planned_fees = current_user.planned_fees.order(:name)
  end

  def new
    @planned_fee = PlannedFee.new(currency_id: Currency.default_currency.id)
  end
  
  def create
    @planned_fee = current_user.planned_fees.new(permitted_params)
    if @planned_fee.valid?
      @planned_fee.save
      redirect_to planned_fees_path, notice: t('planned_fee.created')
    else
      flash[:error] = t('planned_fee.not_created')
      render "new"
    end
  end
  
  def edit
    @planned_fee = current_user.planned_fees.find_by_id(params[:id])
  end
  
  def update
    @planned_fee = current_user.planned_fees.find_by_id(params[:id])
    respond_to do |format|
      if @planned_fee.update_attributes(permitted_params)
        format.html { redirect_to planned_fees_path, notice: t('planned_fee.updated') }
        format.json { respond_with_bip(@planned_fee) }
      else
        format.html { render "edit" }
        format.json { respond_with_bip(@planned_fee) }
      end
    end
  end
  
  def destroy
    @planned_fee = current_user.planned_fees.find_by_id(params[:id])
    @planned_fee.destroy
    redirect_to planned_fees_path, notice: t('planned_fee.deleted')
  end
  
  private
  def permitted_params
    params[:planned_fee].permit(:name, :amount, :currency_id, :status)
  end
end
