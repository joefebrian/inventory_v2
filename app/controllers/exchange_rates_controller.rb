class ExchangeRatesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource
  
  def index
    @search = current_company.exchange_rates.search(params[:search])
    @exchange_rates = @search.paginate(:page => params[:page])
  end
  
  def show
    @exchange_rate = current_company.exchange_rates.find(params[:id])
  end
  
  def new
    @exchange_rate = current_company.exchange_rates.new
    @currency = current_company.currencies
  end
  
  def create
    @exchange_rate = current_company.exchange_rates.new(params[:exchange_rate])
    if @exchange_rate.save
      flash[:notice] = "Successfully created exchange rate."
      redirect_to @exchange_rate
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
    @exchange_rate = current_company.exchange_rates.find(params[:id])
    @exchange_rate.destroy
    flash[:notice] = "Successfully destroyed exchange rate."
    redirect_to exchange_rates_url
  end
  
  private
  def assign_tab
    @tab = 'administrations'
    @current = 'er'
  end
  
end
