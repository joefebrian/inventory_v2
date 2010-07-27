class Purchasing::PurchaseOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  def index
    @purchase_orders = current_company.purchase_orders.all
  end
  
  def show
    @purchase_order = current_company.purchase_orders.find(params[:id])
  end
  
  def new
    @purchase_order = current_company.purchase_orders.new
  end
  
  def create
    @purchase_order = current_company.purchase_orders.new(params[:purchase_order])
    if @purchase_order.save
      flash[:notice] = "Successfully created purchase order."
      redirect_to [:purchase, @purchase_order]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @purchase_order = current_company.purchase_orders.find(params[:id])
  end
  
  def update
    @purchase_order = current_company.purchase_orders.find(params[:id])
    if @purchase_order.update_attributes(params[:purchase_order])
      flash[:notice] = "Successfully updated purchase order."
      redirect_to [:purchasing, @purchase_order]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @purchase_order = current_company.purchase_orders.find(params[:id])
    @purchase_order.destroy
    flash[:notice] = "Successfully destroyed purchase order."
    redirect_to purchasing_purchase_orders_url
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'po'
  end
end
