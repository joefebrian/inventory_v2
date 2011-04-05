module Projects
  class SalesOrdersController < ApplicationController
    load_and_authorize_resource :project, :through => :current_company
    authorize_resource :sales_order
    before_filter :authenticate
    before_filter :assign_tab

    def index
      @search = @project.sales_orders.search(params[:search])
      @sales_orders = @search
    end

    def new
      @sales_order = current_company.sales_orders.new(:project_id => @project.id, :tanggal => Time.now.to_date, :order_ref => "Project #{@project.number}", :customer_id => @project.customer_id, :salesman_id => @project.salesman_id)
      @project.materials.each do |mtr|
        @sales_order.entries.build(:item_id => mtr.item_id, :quantity => mtr.value, :discount => 0, :price => mtr.item.latest_hpp)
      end
    end

    def create
      @sales_order = current_company.sales_orders.new(:project_id => @project.id)
      @sales_order.attributes = params[:sales_order]
      if @sales_order.save
        flash[:notice] = "Successfully created sales order."
        redirect_to project_sales_order_path(@sales_order.project, @sales_order)
      else
        render :action => 'new'
      end
    end

    def show
      @sales_order = @project.sales_orders.find(params[:id])
    end

    def preparation
      @sales_order = @project.sales_orders.find(params[:id])
    end

    def prepared
      @sales_order = @project.sales_orders.find(params[:id])
      if @sales_order.update_attributes(params[:sales_order])
        flash[:success] = "Sales Order #{@sales_order.number} prepared"
        redirect_to project_sales_order_path(@project, @sales_order)
      else
        render :action => "preparation"
      end
    end

    private
    def assign_tab
      @tab = "transactions"
      @current = "prj"
      @currencies = current_company.currencies
    end
  end
end
