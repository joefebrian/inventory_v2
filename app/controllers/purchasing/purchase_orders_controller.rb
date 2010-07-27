class Purchasing::PurchaseOrdersController < ApplicationController
  def index
    @purchasing/purchase_orders = Purchasing::purchaseOrder.all
  end
  
  def show
    @purchasing/purchase_order = Purchasing::purchaseOrder.find(params[:id])
  end
  
  def new
    @purchasing/purchase_order = Purchasing::purchaseOrder.new
  end
  
  def create
    @purchasing/purchase_order = Purchasing::purchaseOrder.new(params[:purchasing/purchase_order])
    if @purchasing/purchase_order.save
      flash[:notice] = "Successfully created purchasing/purchase order."
      redirect_to @purchasing/purchase_order
    else
      render :action => 'new'
    end
  end
  
  def edit
    @purchasing/purchase_order = Purchasing::purchaseOrder.find(params[:id])
  end
  
  def update
    @purchasing/purchase_order = Purchasing::purchaseOrder.find(params[:id])
    if @purchasing/purchase_order.update_attributes(params[:purchasing/purchase_order])
      flash[:notice] = "Successfully updated purchasing/purchase order."
      redirect_to @purchasing/purchase_order
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @purchasing/purchase_order = Purchasing::purchaseOrder.find(params[:id])
    @purchasing/purchase_order.destroy
    flash[:notice] = "Successfully destroyed purchasing/purchase order."
    redirect_to purchasing/purchase_orders_url
  end
end
