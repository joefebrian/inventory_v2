class DeliveryOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @search = current_company.delivery_orders.search(params[:search])
    @delivery_orders = @search.paginate(:page => params[:page])
  end

  def show
    @delivery_order = current_company.delivery_orders.find(params[:id])
      respond_to do |format|
        if(params[:type])
            format.html { render "print", :layout => "print"}
        else
            format.html { render "show", :layout => "application"}
        end
      end
  end

  def new
    @customer = current_company.customers.all(:include => :profile)
    @delivery_order = current_company.delivery_orders.new
    @delivery_order.attributes = params[:delivery_order] if params[:delivery_order]
    @warehouses = current_company.warehouses.all
    if params[:delivery_order]
      @sales_orders = current_company.sales_orders.all_open.customer_id_is(params[:delivery_order][:customer_id])
    else
      @sales_orders = current_company.sales_orders.all_open
    end
    if request.xhr?
      render :layout => false
    end
  end

  def create
    @delivery_order = current_company.delivery_orders.new
    @delivery_order.attributes = params[:delivery_order]
    if params[:get_sos] && params[:get_sos].to_i == 1
      @delivery_order.customer = @delivery_order.sales_order.customer
      @delivery_order.build_entries_from_so
      render("new", :layout => false) and return
    end
    if @delivery_order.save
      flash[:notice] = "Successfully created delivery order."
      redirect_to @delivery_order
    else
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

