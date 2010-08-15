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
    @purchase_order.entries.build
    @suppliers = current_company.suppliers.all(:include => :profile)
  end
  
  def create
    @purchase_order = current_company.purchase_orders.new(params[:purchase_order])
    @suppliers = current_company.suppliers.all(:include => :profile)
    if params[:get_mrs] && params[:get_mrs].to_i == 1
      @purchase_order.build_entries_from_mr
      @purchase_order.entries.build
      render("new", :layout => false) and return
    end
    if @purchase_order.save
      flash[:notice] = "Successfully created purchase order."
      redirect_to [:purchasing, @purchase_order]
    else
      @purchase_order.entries.build
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
    @suppliers = current_company.suppliers
    if params[:get_mrs] && params[:get_mrs].to_i == 1
      @purchase_order.build_entries_from_mr
      @purchase_order.entries.build
      render("edit", :layout => false) and return
    end
    if @purchase_order.update_attributes(params[:purchase_order])
      flash[:notice] = "Successfully updated purchase order."
      redirect_to [:purchasing, @purchase_order]
    else
      @purchase_order.entries.build
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
