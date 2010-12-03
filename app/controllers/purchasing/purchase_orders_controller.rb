class Purchasing::PurchaseOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @search = current_company.purchase_orders.search(params[:search])
    if params[:state] == 'closed'
      @purchase_orders = @search.search(:closed => true).paginate(:page => params[:page])
    elsif params[:state] == 'all'
      @purchase_orders = @search.paginate(:page => params[:page])
    else
      @purchase_orders = @search.search(:closed => false).paginate(:page => params[:page])
    end
  end

  def show
    @purchase_order = current_company.purchase_orders.find(params[:id])
      respond_to do |format|
        if(params[:type])
            format.html { render "print", :layout => "print"}
        else
            format.html { render "show", :layout => "application"}
        end
      end
  end

  def new
    @purchase_order = current_company.purchase_orders.new
    @purchase_order.entries.build
    @suppliers = current_company.suppliers.all(:include => :profile)
    @material_requests = current_company.material_requests.not_closed
  end

  def create
    @purchase_order = current_company.purchase_orders.new(params[:purchase_order])
    @suppliers = current_company.suppliers.all(:include => :profile)
    @material_requests = current_company.material_requests.not_closed
    if params[:get_mrs] && params[:get_mrs] == '1'
        @purchase_order.build_entries_from_mr
        @purchase_order.build_mr_trackers
        @purchase_order.entries.build
      render('new') and return
    end
    if @purchase_order.save
      @purchase_order.populate_total
      flash[:success] = "Purchase Order saved"
      redirect_to [:purchasing, @purchase_order]
    else
      render 'new'
    end
  end

  def edit
    @purchase_order = current_company.purchase_orders.find(params[:id])
    @suppliers = current_company.suppliers.all(:include => :profile)
    @material_requests = current_company.material_requests.all(:conditions => ["closed = 0 OR id IN (?)", @purchase_order.material_requests.collect { |mr| mr.id }])
  end

  def update
    @purchase_order = current_company.purchase_orders.find(params[:id])
    @suppliers = current_company.suppliers.all(:include => :profile)
    @material_requests = current_company.material_requests.not_closed

    updated = @purchase_order.update_attributes(params[:purchase_order])
    if updated
      @purchase_order.populate_total
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

  def manual_close
    @purchase_order = current_company.purchase_orders.find(params[:id])
  end

  def close
    @purchase_order = current_company.purchase_orders.find(params[:id])
    @purchase_order.closed = true
    @purchase_order.closing_note = params[:purchase_order][:closing_note]
    if @purchase_order.save
      flash[:success] = "Purchase Order # #{@purchase_order.number} successfuly closed"
      redirect_to purchasing_purchase_orders_url
    else
      flash[:error] = "Something went wrong, please try again"
      render :action => 'manual_close'
    end
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'po'
  end
end

