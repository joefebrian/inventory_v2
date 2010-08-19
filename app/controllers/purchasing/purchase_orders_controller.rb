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
    session[:po_params] ||= {}
    @purchase_order = current_company.purchase_orders.new
    @purchase_order.entries.build
    @purchase_order.current_step = session[:po_step]
    @suppliers = current_company.suppliers.all(:include => :profile)
  end
  
  def create
    session[:po_params].deep_merge!(params[:purchase_order]) if params[:purchase_order]
    @purchase_order = current_company.purchase_orders.new(session[:po_params])
    @suppliers = current_company.suppliers.all(:include => :profile)
    @purchase_order.current_step = session[:po_step]
    if @purchase_order.valid?
      if params[:back_button]
        @purchase_order.previous_step
      elsif @purchase_order.last_step?
        @purchase_order.save
      else
        @purchase_order.next_step
        @purchase_order.build_entries_from_mr
        @purchase_order.entries.build
      end
      session[:po_step] = @purchase_order.current_step
    end

    if @purchase_order.new_record?
      render "new"
    else
      session[:po_params] = session[:po_step] = nil
      flash[:success] = "Purchase Order saved"
      redirect_to [:purchasing, @purchase_order]
    end
  end
  
  def edit
    session[:po_params] ||= {}
    @purchase_order = current_company.purchase_orders.find(params[:id])
    @purchase_order.current_step = session[:po_step]
    @suppliers = current_company.suppliers.all(:include => :profile)
  end
  
  def update
    session[:po_params].deep_merge!(params[:purchase_order]) if params[:purchase_order]
    @purchase_order = current_company.purchase_orders.find(params[:id])
    @purchase_order.attributes = session[:po_params]
    @purchase_order.current_step = session[:po_step]
    @suppliers = current_company.suppliers.all(:include => :profile)

    updated = nil
    if @purchase_order.valid?
      if params[:back_button]
        @purchase_order.previous_step
      elsif @purchase_order.last_step?
        @purchase_order.entries.reject! { |e| e.id.nil? } # prevent double entries get saved when adding new entries
        updated = @purchase_order.update_attributes(session[:po_params])
      else
        @purchase_order.next_step
      end
      session[:po_step] = @purchase_order.current_step
    end

    if updated
      session[:po_params] = session[:po_step] = nil
      flash[:success] = "Purchase Order updated"
      redirect_to [:purchasing, @purchase_order]
    else
      @purchase_order.entries.build
      render "edit"
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
