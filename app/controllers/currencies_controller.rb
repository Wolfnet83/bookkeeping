class CurrenciesController < ApplicationController
  before_action :authenticate_user!

  def index
    @currencies = Currency.all.order(:name)
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

  def edit
    @currency = Currency.find_by_id(params[:id])
  end

  def update
    @currency = Currency.find_by_id(params[:id])
    if @currency.update_attributes(permitted_params)
      redirect_to currencies_path, notice: t('currency.updated')
    else
      flash[:error] = t('currency.not_updated')
      render "edit"
    end
  end

  def destroy
    @currency = Currency.find_by_id(params[:id])
    @currency.destroy
    redirect_to currencies_path, notice: t('currency.deleted')
  end

  def update_exchange_rates
    Currency.get_exchange_rates
    redirect_to currencies_path, notice: t('currency.updated')
  end

  private
  def permitted_params
    params[:currency].permit(:name, :abbr_name, :exchange_rate, :default_currency)
  end
end
