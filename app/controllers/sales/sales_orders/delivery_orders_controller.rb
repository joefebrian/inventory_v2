module Sales
  module SalesOrders
    class DeliveryOrdersController < ApplicationController
      before_filter :authenticate
      before_filter :assign_tab
      load_and_authorize_resource :sales_order, :through => :current_company
      authorize_resource

      def index
        @search = @sales_order.delivery_orders.search(params[:search])
        @delivery_orders = @search.paginate(:page => params[:page])
      end

      def show
        @delivery_order = @sales_order.delivery_orders.find(params[:id])
      end

      def update
        @delivery_order = @sales_order.delivery_orders.find(params[:id])
        if @delivery_order.update_attributes(params[:delivery_order])
          flash[:success] = "Delivery Order updated"
          redirect_to [:sales, @sales_order, @delivery_order]
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
        @current = "do"
      end
    end
  end
end
