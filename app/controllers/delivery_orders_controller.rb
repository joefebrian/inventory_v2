class DeliveryOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  
  def index
    @delivery_orders = current_company.delivery_orders.all
  end
  
  def show
    @delivery_order = current_company.delivery_orders.find(params[:id])
  end
  
  def new
    @customer = current_company.customers.all(:include => :profile)
    @delivery_order = current_company.delivery_orders.new
    @delivery_order.entries.build
    @sales_orders = current_company.sales_orders
  end
  
  def create
    @delivery_order = current_company.delivery_orders.new(params[:delivery_order])
    if params[:get_sos] && params[:get_sos].to_i == 1
      @delivery_order.build_entries_from_so
      @delivery_order.entries.build
      render("new", :layout => false) and return
    end
    if @delivery_order.save
      flash[:notice] = "Successfully created sales order."
      redirect_to [:sales, @delivery_order]
    else
      @delivery_order.entries.build
      @sales_orders = current_company.sales_orders
      @customer = current_company.customers.all(:include => :profile)
      render :action => 'new'
    end
  end

  
  def edit
    @delivery_order = current_company.delivery_orders.find(params[:id])
    @customer = current_company.customers.all(:include => :profile)
  end
  
  def update
    @delivery_order = current_company.delivery_orders.find(params[:id])
    if @delivery_order.update_attributes(params[:delivery_order])
      flash[:notice] = "Successfully updated delivery order."
      redirect_to @delivery_order
    else
      @delivery_order.entries.build
      @customer = current_company.customers.all(:include => :profile)
      render :action => 'edit'
    end
  end
  
  def destroy
    @delivery_order = current_company.delivery_orders.find(params[:id])
    @delivery_order.destroy
    flash[:notice] = "Successfully destroyed delivery order."
    redirect_to delivery_orders_url
  end
  
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'do'
  end
 
end
