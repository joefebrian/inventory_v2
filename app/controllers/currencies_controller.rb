class CurrenciesController < ApplicationController
   before_filter :authenticate
   before_filter :assign_tab

  def index
    @currencies = current_company.currencies.paginate(:page => params[:page])
  end
  
  def show
    @currency = current_company.currencies.find(params[:id])
  end
  
  def new
    @currency = current_company.currencies.new
  end
  
  def create
    @currency = current_company.currencies.new(params[:currency])
    if @currency.save
      flash[:notice] = "Successfully created currency."
      redirect_to @currency
    else
      render :action => 'new'
    end
  end
  
  def edit
    @currency = current_company.currencies.find(params[:id])
  end
  
  def update
    @currency = current_company.currencies.find(params[:id])
    if @currency.update_attributes(params[:currency])
      flash[:notice] = "Successfully updated currency."
      redirect_to @currency
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @currency = current_company.currencies.find(params[:id])
    @currency.destroy
    flash[:notice] = "Successfully destroyed currency."
    redirect_to currencies_url
  end
  
  private
  def assign_tab
    @tab = 'administrations'
    @current = 'curr'
  end
end