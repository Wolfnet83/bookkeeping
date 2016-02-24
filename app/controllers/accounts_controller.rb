class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts.order(:name)
  end

  def new
    @account = Account.new
  end

  def create
    @account = current_user.accounts.new(permitted_params)
    if @account.valid?
      @account.save
      redirect_to accounts_path, notice: t('account.created')
    else
      flash[:error] = "Account doesn't created"
      render "new"
    end
  end

  def edit
    @account = current_user.accounts.find_by_id(params[:id])
  end

  def update
    @account = current_user.accounts.find_by_id(params[:id])
    if @account.update_attributes(permitted_params)
      redirect_to accounts_path, notice: t('account.updated')
    else
      flash[:error] = "Account doesn't updated"
      render "edit"
    end
  end

  def destroy
    @account = current_user.accounts.find_by_id(params[:id])
    @account.destroy
    redirect_to accounts_path, notice: t('account.deleted')
  end

  private
  def permitted_params
    params[:account].permit(:name, :funds)
  end
end
