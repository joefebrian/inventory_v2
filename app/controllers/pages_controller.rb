class PagesController < ApplicationController
  before_filter :authenticate, :except => [:index]
  def index
    if current_user
      @tab = 'dashboard'
      @unconfirmed_item_receives = current_company.item_receives.unconfirmed
      @open_purchase_orders = current_company.purchase_orders.all_open
      @minus_items = current_company.items.reject { |i| i.stock > 0 }
    else
      redirect_to signin_path
    end
  end

  def show
    @tab = params[:id]
    if params[:id] == 'administrations'
      unless current_user.roles?('admin')
        flash[:error] = "Sorry, you are not allowed to access that page"
        redirect_to dashboard_path and return
      end
    end
    render @tab
  end
  
  def sales
    @tab = 'transactions'
    @current = 'sales'
    @quotation = current_company.quotations.last
    @sales_order = current_company.sales_orders.last
    @delivery_order = current_company.delivery_orders.last
    @sales_invoice = current_company.sales_invoices.last
    @sales_return = current_company.sales_returns.last
    @direct_sale = current_company.direct_sales.last
  end
  
  def sales_search
    @tab = 'transactions'
    @current = 'sales'
    @results = {}
    @results[:quotations] = current_company.quotations.number_like(params[:term]) || []
    @results[:sales_orders] = current_company.sales_orders.number_like(params[:term]) || []
    @results[:delivery_orders] = current_company.delivery_orders.number_like(params[:term]) || []
    @results[:sales_invoices] = current_company.sales_invoices.number_like(params[:term]) || []
    @results[:sales_returns] = current_company.sales_returns.number_like(params[:term]) || []
    @results[:direct_sales] = current_company.direct_sales.number_like(params[:term]) || []
    @term = params[:term]
  end
  
  def purchasing
    @tab = 'transactions'
    @current = 'purchasing'
    @material_request = current_company.material_requests.last
    @quotation_request = current_company.quotation_requests.last
    @purchase_order = current_company.purchase_orders.last
    @item_receive = current_company.item_receives.last
    @purchase_return = current_company.purchase_returns.last
    @invoice = current_company.invoices.last
  end

  def purchasing_search
    @tab = 'transactions'
    @current = 'purchasing'
    @results = {}
    @results[:material_requests] = current_company.material_requests.number_like(params[:term]) || []
    @results[:quotation_requests] = current_company.quotation_requests.number_like(params[:term]) || []
    @results[:purchase_orders] = current_company.purchase_orders.number_like(params[:term]) || []
    @results[:item_receives] = current_company.item_receives.number_like(params[:term]) || []
    @results[:purchase_returns] = current_company.purchase_returns.number_like(params[:term]) || []
    @results[:invoices] = current_company.invoices.number_like(params[:term]) || []
    @term = params[:term]
  end
  
  def assembling_disassembling
    @tab = 'transactions'
    @current = 'assy'
    @assembling = current_company.trans_assemblies.last
    @disassembling = current_company.trans_diassemblies.last
  end
  
  def assy_search
    @tab = 'transactions'
    @current = 'purchasing'
    @results = {}
    @results[:assembling] = current_company.trans_assemblies.number_like(params[:term]) || []
    @results[:diassembling] = current_company.trans_diassemblies.number_like(params[:term]) || []
    @term = params[:term]
  end

  def production
    @tab = 'transactions'
    @current = 'prod'
  end
end
