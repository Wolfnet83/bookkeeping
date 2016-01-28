class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new
    @account.update_attributes(permitted_params)
    if @account.valid?
      @account.save
      redirect_to accounts_path, notice: "Account successfully created"
    else
      flash[:alert] = "Account doesn't created"
      render "new"
    end
  end

  def destroy
    @account = Account.find_by_id(params[:id])
    @account.destroy
    redirect_to accounts_path, notice: "Account successfully deleted"
  end

  private
  def permitted_params
    params[:account].permit(:name, :funds)
  end
end
