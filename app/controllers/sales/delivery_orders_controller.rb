module Sales
  class DeliveryOrdersController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :through => :current_company

    def index
      if params[:sales_order_id]
        @sales_order = current_company.sales_orders.find(params[:sales_order_id])
        @search = @sales_order.delivery_orders.search(params[:search])
      elsif params[:project_id]
        @project = current_company.projects.find(params[:project_id])
        @search = @project.delivery_orders.search(params[:search])
      else
        @search = current_company.delivery_orders.search(params[:search])
      end
      @delivery_orders = @search.paginate(:page => params[:page])
    end

    def show
      @delivery_order = current_company.delivery_orders.find(params[:id])
      @sales_order = current_company.sales_orders.find(params[:sales_order_id]) if params[:sales_order_id]
    end

    def new
      @customer = current_company.customers.all(:include => :profile)
      @delivery_order = current_company.delivery_orders.new(:do_date => Time.now.to_date)
      @delivery_order.attributes = params[:delivery_order] if params[:delivery_order]
      @warehouses = current_company.warehouses.all
      if params[:delivery_order]
        @sales_orders = current_company.sales_orders.all_open.customer_id_is(params[:delivery_order][:customer_id])
      else
        @sales_orders = current_company.sales_orders.all_open
      end
      if params[:sales_order_id]
        @sales_order = current_company.sales_orders.find(params[:sales_order_id])
        @delivery_order.sales_order_id = @sales_order.id
        @delivery_order.customer_id = @sales_order.customer_id
        @delivery_order.project_id = @sales_order.project.id if @sales_order.project
        @delivery_order.reference = "Project no. #{@sales_order.project.try(:number)}" if @sales_order.project
        @sales_order.entries.each do |e|
          @delivery_order.entries.build(:plu_id => e.plu_id, :item_id => e.item_id, :quantity => e.undelivered_quantity)
        end
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
        redirect_to [:sales, @delivery_order]
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
        redirect_to [:sales, @delivery_order]
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

    def plu_confirmation
      @delivery_order = current_company.delivery_orders.find(params[:id])
    end

    private
    def assign_tab
      @tab = 'transactions'
      @current = 'do'
    end

  end
end
