class Purchasing::PurchaseOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  def index
    @purchase_orders = current_company.purchase_orders.paginate(:page => params[:page])
  end
  
  def show
    @purchase_order = current_company.purchase_orders.find(params[:id])
  end
  
  def new
    @purchase_order = current_company.purchase_orders.new
    if params[:mr]
      mr = current_company.material_requests.find_by_number(params[:mr], :include => :entries)
      @purchase_order.material_request = mr
      mr.entries.each do |entry|
        @purchase_order.entries.build(:item => entry.item, :quantity => entry.quantity, :purchase_price => 0)
      end
    end
    @purchase_order.entries.build
    @suppliers = current_company.suppliers.all(:include => :profile)
  end
  
  def create
    @purchase_order = current_company.purchase_orders.new(params[:purchase_order])
    if @purchase_order.save
      flash[:notice] = "Successfully created purchase order."
      redirect_to [:purchasing, @purchase_order]
    else
      @purchase_order.entries.build
      @suppliers = current_company.suppliers.all(:include => :profile)
      render :action => 'new'
    end
  end
  
  def edit
    @purchase_order = current_company.purchase_orders.find(params[:id])
    @purchase_order.entries.build
    @suppliers = current_company.suppliers
  end
  
  def update
    @purchase_order = current_company.purchase_orders.find(params[:id])
    if @purchase_order.update_attributes(params[:purchase_order])
      flash[:notice] = "Successfully updated purchase order."
      redirect_to [:purchasing, @purchase_order]
    else
      @purchase_order.entries.build
      @suppliers = current_company.suppliers
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
