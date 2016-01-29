class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.all
  end

  def show
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
    params[:transaction].permit(:account_id, :category_id, :amount)
  end
end
