class SalesReturnsController < ApplicationController
  
  before_filter :authenticate
  before_filter :assign_tab
   
  def index
    @search = current_company.sales_returns.search(params[:search])
    @sales_returns = @search.paginate(:page => params[:page])
  end
  
  def show
    @sales_return = current_company.sales_returns.find(params[:id])
  end

  def new
    @sales_return = current_company.sales_returns.new
    @sales_return.entries.build
    @customer = current_company.customers
  end  
  
  def create
    @sales_return = current_company.sales_returns.new(params[:sales_return])
    if @sales_return.save
      flash[:notice] = "Successfully created Sales Return."
      redirect_to sales_return_path(@sales_return)
    else
      @sales_return.entries.build
      render :action => 'new'
    end
  end

  def edit
    @sales_return = current_company.sales_returns.find(params[:id])
    @sales_return.entries.build
  end
  
  def update
    @sales_return = current_company.sales_returns.find(params[:id])
    if @sales_return.update_attributes(params[:sales_return])
      flash[:notice] = "Successfully updated Sales Return."
      redirect_to sales_return_path(@sales_return)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sales_return = current_company.sales_returns.find(params[:id])
    @sales_return.destroy
    flash[:notice] = "Successfully destroyed Sales Return."
    redirect_to sales_return_url
  end 

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'sr'
  end
 
end
