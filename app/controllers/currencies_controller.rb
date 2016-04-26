class CurrenciesController < ApplicationController
  before_action :authenticate_user!

  def index
    @currencies = Currency.all
  end

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(permitted_params)
    if @currency.valid?
      @currency.save
      redirect_to currencies_path, notice: t('currency.created')
    else
      flash[:error] = t('currency.not_created')
      render "new"
    end
  end

  def destroy
    @currency = Currency.find_by_id(params[:id])
    @currency.destroy
    redirect_to currencies_path, notice: t('currency.deleted')
  end

  private
  def permitted_params
    params[:currency].permit(:name, :abbr_name)
  end
end
