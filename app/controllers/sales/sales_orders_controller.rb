class Sales::SalesOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @sales_orders = current_company.sales_orders.all
  end
  
  def show
    @sales_order = current_company.sales_orders.find(params[:id])
  end
  
  def new
    @sales_order = current_company.sales_orders.new
    @sales_order.entries.build
    @customer = current_company.customers
    @quotation = current_company.quotations
    @assembly = current_company.assemblies
    @kurs_id = current_company.kurs_ids
    @kurs_rate = current_company.kurs_rates
  end
  
  def create
    @sales_order = current_company.sales_orders.new(params[:sales_order])
    if @sales_order.save
      flash[:notice] = "Successfully created sales order."
      redirect_to @sales_order
    else
      render :action => 'new'
    end
  end
  
  def edit
    @sales_order = current_company.sales_order.find(params[:id])
  end
  
  def update
    @sales_order = current_company.sales_order.find(params[:id])
    if @sales_order.update_attributes(params[:sales_order])
      flash[:notice] = "Successfully updated sales order."
      redirect_to @sales_order
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sales_order = current_company.SalesOrder.find(params[:id])
    @sales_order.destroy
    flash[:notice] = "Successfully destroyed sales order."
    redirect_to sales_orders_url
  end
  
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'so'
  end

end
