class ExchangeRatesController < ApplicationController
  def index
    @exchange_rates = ExchangeRate.all
  end
  
  def show
    @exchange_rate = ExchangeRate.find(params[:id])
  end
  
  def new
    @exchange_rate = ExchangeRate.new
  end
  
  def create
    @exchange_rate = ExchangeRate.new(params[:exchange_rate])
    if @exchange_rate.save
      flash[:notice] = "Successfully created exchange rate."
      redirect_to @exchange_rate
    else
      render :action => 'new'
    end
  end
  
  def edit
    @exchange_rate = ExchangeRate.find(params[:id])
  end
  
  def update
    @exchange_rate = ExchangeRate.find(params[:id])
    if @exchange_rate.update_attributes(params[:exchange_rate])
      flash[:notice] = "Successfully updated exchange rate."
      redirect_to @exchange_rate
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @exchange_rate = ExchangeRate.find(params[:id])
    @exchange_rate.destroy
    flash[:notice] = "Successfully destroyed exchange rate."
    redirect_to exchange_rates_url
  end
end
