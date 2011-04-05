module Projects
  class DeliveryOrdersController < ApplicationController
    before_filter :set_tab
    before_filter :authenticate
    load_and_authorize_resource :project, :through => :current_company
    authorize_resource 

    def index
      @search = @project.delivery_orders.search(params[:search])
      @delivery_orders = @search
    end

    def show
      @delivery_order = @project.delivery_orders.find(params[:id])
    end

    def new
      @sales_orders = @project.sales_orders
      @warehouses = current_company.warehouses
      @delivery_order = @project.delivery_orders.new(:company_id => current_company.id, :do_date => Time.now.to_date, :customer_id => @project.customer_id, :reference => "Project #{@project.number}")
    end

    def create
      @delivery_order = current_company.delivery_orders.new(params[:delivery_order])
      if params[:get_sos]
        @delivery_order.customer = @delivery_order.sales_order.customer
        @delivery_order.build_entries_from_so
        render("new", :layout => false) and return
      end
      if @delivery_order.save
        flash[:success] = "Delivery Order created"
        redirect_to [@project, @delivery_order]
      else
        render :action => "new"
      end
    end
    
    def plu_confirmation
      @delivery_order = @project.delivery_orders.find(params[:id])
    end

    def update
      @delivery_order = @project.delivery_orders.find(params[:id])
      if @delivery_order.update_attributes(params[:delivery_order])
        flash[:success] = "Delivery Order updated"
        redirect_to [@project, @delivery_order]
      else
        render :action => "edit"
      end
    end
    private
    def set_tab
      @tab = 'transactions'
      @current = 'prj'
    end
  end
end
