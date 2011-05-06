module Projects
  class InvoicesController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :project, :through => :current_company
    authorize_resource :class => "SalesInvoice"

    def new
      @invoice = current_company.sales_invoices.new(:user_date => Time.now.to_date, :discount => 0)
      @delivery_orders = @project.delivery_orders
      if params[:do_ids]
        @invoice.delivery_order_ids = params[:do_ids]
      end
    end

    private
    def assign_tab
      @tab = "transactions"
      @current = "prj"
    end
  end
end
