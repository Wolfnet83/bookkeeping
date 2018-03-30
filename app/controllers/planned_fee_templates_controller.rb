class PlannedFeeTemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @planned_fee_templates = current_user.planned_fee_templates.order(:name)
  end

  def new
    @planned_fee_template = PlannedFeeTemplate.new(currency_id: Currency.default_currency.id)
  end
  
  def create
    @planned_fee_template = current_user.planned_fee_templates.new(permitted_params)
    if @planned_fee_template.valid?
      @planned_fee_template.save
      redirect_to planned_fee_templates_path, notice: t('planned_fee.created')
    else
      flash[:error] = t('planned_fee.not_created')
      render "new"
    end
  end
  
  def edit
    @planned_fee_template = current_user.planned_fee_templates.find_by_id(params[:id])
  end

  def update
    @planned_fee_template = current_user.planned_fee_templates.find_by_id(params[:id])
    respond_to do |format|
      if @planned_fee_template.update_attributes(permitted_params)
        format.html { redirect_to planned_fee_templates_path, notice: t('planned_fee.updated') }
        format.json { respond_with_bip(@planned_fee_template) }
      else
        format.html { render "edit" }
        format.json { respond_with_bip(@planned_fee_template) }
      end
    end
  end
  

  def destroy
    @planned_fee_template = current_user.planned_fee_templates.find_by_id(params[:id])
    @planned_fee_template.destroy
    redirect_to planned_fee_templates_path, notice: t('planned_fee.deleted')
  end

  def create_for_month
    PlannedFeeTemplate.create_monthly_fees
    redirect_to planned_fees_path
  end
  
  private
  def permitted_params
    params[:planned_fee_template].permit(:name, :amount, :currency_id)
  end
end
