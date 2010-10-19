class SalesReturnsController < ApplicationController
  def index
    @sales_returns = SalesReturn.all
  end
  
  def show
    @sales_return = SalesReturn.find(params[:id])
  end
  
  def new
    @sales_return = SalesReturn.new
  end
  
  def create
    @sales_return = SalesReturn.new(params[:sales_return])
    if @sales_return.save
      flash[:notice] = "Successfully created sales return."
      redirect_to @sales_return
    else
      render :action => 'new'
    end
  end
  
  def edit
    @sales_return = SalesReturn.find(params[:id])
  end
  
  def update
    @sales_return = SalesReturn.find(params[:id])
    if @sales_return.update_attributes(params[:sales_return])
      flash[:notice] = "Successfully updated sales return."
      redirect_to @sales_return
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sales_return = SalesReturn.find(params[:id])
    @sales_return.destroy
    flash[:notice] = "Successfully destroyed sales return."
    redirect_to sales_returns_url
  end
end
