module Sales
  class InvoiceController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :through => :current_company

    def show
      @delivery_order = current_company.delivery_orders.find(params[:delivery_order_id])
      @invoice = @delivery_order.invoice
    end
    
    def new
      @delivery_order = current_company.delivery_orders.find(params[:delivery_order_id])
      @invoice = current_company.sales_invoices.new(:delivery_order_ids => [@delivery_order.id], :user_date => Time.now.to_date, :discount => 0)
      if params[:do_ids]
        @invoice.delivery_order_ids = params[:do_ids]
      end
    end

    def create
      @delivery_order = current_company.delivery_orders.find(params[:delivery_order_id])
      @invoice = current_company.sales_invoices.new(params[:sales_invoice])
      if @invoice.save
        flash[:success] = "Sales Invoice created"
        redirect_to sales_delivery_order_invoice_path(@delivery_order)
      else
      end
    end

    private
    def assign_tab
      @tab = 'transactions'
      @current = 'invoices'
    end
  end
end
