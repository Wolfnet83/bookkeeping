class PlannedFeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @planned_fees = current_user.planned_fees.order(:name)
  end

  # def new
  #   @account = Account.new
  # end
  #
  # def create
  #   @account = current_user.accounts.new(permitted_params)
  #   if @account.valid?
  #     @account.save
  #     redirect_to accounts_path, notice: t('account.created')
  #   else
  #     flash[:error] = t('account.not_created')
  #     render "new"
  #   end
  # end
  #
  # def edit
  #   @account = current_user.accounts.find_by_id(params[:id])
  # end
  #
  def update
    @planned_fee = current_user.planned_fees.find_by_id(params[:id])
    respond_to do |format|
      if @planned_fee.update_attributes(permitted_params)
        format.html { redirect_to planned_fees_path, notice: "Planned fee updated" }
        format.json { respond_with_bip(@planned_fee) }
      else
        format.html { render "edit" }
        format.json { respond_with_bip(@planned_fee) }
      end
    end
    # if @planned_.update_attributes(permitted_params)
    #   redirect_to accounts_path, notice: t('account.updated')
    # else
    #   flash[:error] = t('account.not_updated')
    #   render "edit"
    # end
  end
  #
  # def destroy
  #   @account = current_user.accounts.find_by_id(params[:id])
  #   @account.destroy
  #   redirect_to accounts_path, notice: t('account.deleted')
  # end
  #
  private
  def permitted_params
    params[:planned_fee].permit(:name, :amount, :paid)
  end
end
