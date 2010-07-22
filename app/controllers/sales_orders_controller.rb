class SalesOrdersController < ApplicationController
  def index
    @sales_orders = SalesOrder.all
  end
  
  def show
    @sales_order = SalesOrder.find(params[:id])
  end
  
  def new
    @sales_order = SalesOrder.new
  end
  
  def create
    @sales_order = SalesOrder.new(params[:sales_order])
    if @sales_order.save
      flash[:notice] = "Successfully created sales order."
      redirect_to @sales_order
    else
      render :action => 'new'
    end
  end
  
  def edit
    @sales_order = SalesOrder.find(params[:id])
  end
  
  def update
    @sales_order = SalesOrder.find(params[:id])
    if @sales_order.update_attributes(params[:sales_order])
      flash[:notice] = "Successfully updated sales order."
      redirect_to @sales_order
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.destroy
    flash[:notice] = "Successfully destroyed sales order."
    redirect_to sales_orders_url
  end
end
