module Projects
  module SalesOrders
    class DeliveryOrdersController < ApplicationController
      before_filter :authenticate
      before_filter :assign_tab
      load_and_authorize_resource :project, :through => :current_company
      load_and_authorize_resource :sales_order, :through => :project
      authorize_resource :delivery_order

      def index
        @search = @sales_order.delivery_orders.search(params[:search])
        @delivery_orders = @search
      end

      def show
        @delivery_order = @sales_order.delivery_orders.find(params[:id])
      end

      def new
        @delivery_order = current_company.delivery_orders.new(:project_id => @project.id, :sales_order_id => @sales_order.id, :do_date => Time.now.to_date, :reference => "Project #{@project.number}", :customer_id => @project.customer.id)
        @sales_order.entries.each do |e|
          @delivery_order.entries.build(:plu_id => e.plu_id, :item_id => e.item_id, :quantity => e.undelivered_quantity)
        end
      end

      def create
        @delivery_order = current_company.delivery_orders.new(:project_id => @project.id, :sales_order_id => @sales_order.id)
        @delivery_order.attributes = params[:delivery_order]
        if @delivery_order.save
          flash[:notice] = "Successfully created delivery order."
          redirect_to project_sales_order_delivery_order_path(@project, @sales_order, @delivery_order)
        else
          @sales_orders = current_company.sales_orders
          @customer = current_company.customers.all(:include => :profile)
          render :action => 'new'
        end
      end

      def update
        @delivery_order = @sales_order.delivery_orders.find(params[:id])
        if @delivery_order.update_attributes(params[:delivery_order])
          flash[:success] = "Delivery Order updated"
          redirect_to [@project, @sales_order, @delivery_order]
        else
          render :action => "edit"
        end
      end

      def plu_confirmation
        @delivery_order = @sales_order.delivery_orders.find(params[:id])
      end

      private
      def assign_tab
        @tab = "transactions"
        @current = "prj"
      end
      
    end
  end
end

