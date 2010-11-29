class ExchangeRatesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource
  
  def index
    @currency = current_company.currencies.find(params[:currency_id])
    @search = @currency.exchange_rates.search(params[:search])
    @exchange_rates = @search.paginate(:page => params[:page])
  end
  
  def show
    @exchange_rate = current_company.exchange_rates.find(params[:id])
  end
  
  def new
    @currency = current_company.currencies.find(params[:currency_id])
    @exchange_rate = @currency.exchange_rates.new(:effective_date => Time.now.to_date)
  end
  
  def create
    @currency = current_company.currencies.find(params[:currency_id])
    @exchange_rate = @currency.exchange_rates.new(params[:exchange_rate])
    if @exchange_rate.save
      flash[:notice] = "Successfully created exchange rate."
      redirect_to currency_exchange_rates_path(@currency)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @exchange_rate = current_company.exchange_rates.find(params[:id])
    @currency = current_company.currencies
  end

  def update
    @exchange_rate = current_company.exchange_rates.find(params[:id])
    if @exchange_rate.update_attributes(params[:exchange_rate])
      flash[:notice] = "Successfully updated exchange rate."
      redirect_to @exchange_rate
    else
      render :action => 'edit'
    end
  end

  def destroy
    @currency = current_company.currencies.find(params[:currency_id])
    @exchange_rate = @currency.exchange_rates.find(params[:id])
    @exchange_rate.destroy
    flash[:notice] = "Successfully destroyed exchange rate."
    redirect_to currency_exchange_rates_path(@currency)
  end

  private
  def assign_tab
    @tab = 'administrations'
    @current = 'curr'
  end
end
