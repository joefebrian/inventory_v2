class Sales::SalesOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @search = current_company.sales_orders.search(params[:search])
    if params[:state] == 'closed'
      @sales_orders = @search.search(:closed => true)
    elsif params[:state] == 'all'
      @sales_orders = @search.all
    else
      @sales_orders = @search.search(:closed => false)
    end
    @sales_orders.paginate(:page => params[:page])
  end
  
  def show
    @sales_order = current_company.sales_orders.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf { render :pdf => "show", :css => %w(print) }  #add this line
      end

  end

  def printshow
    @sales_order = current_company.sales_orders.find(params[:id])
      respond_to do |format|
        format.pdf { render :layout => print }  #add this line
      end
  end
  
  def new
    @sales_order = current_company.sales_orders.new
    #@sales_order.attributes = params[:sales_order] if params[:sales_order]
    if params[:sales_order]
      @quotations = current_company.quotations.customer_id_is(params[:sales_order][:customer_id])
    else
      @quotations = current_company.quotations
    end
    @sales_order.entries.clear
    @sales_order.entries.build
    @customer = current_company.customers
    @assembly = current_company.assemblies
    @currencies = current_company.currencies
    @exchange_rate = current_company.exchange_rates
    @salesman = current_company.salesmen
    if request.xhr?
      render :layout => false
    end
  end
  
  def create
    @sales_order = current_company.sales_orders.new
    @sales_order.attributes = params[:sales_order]
    if params[:get_quots] && params[:get_quots].to_i == 1
      @sales_order.build_entries_from_quot
      @sales_order.entries.build
      @currencies = current_company.currencies
      render("new", :layout => false) and return
    end
    if @sales_order.save
      flash[:notice] = "Successfully created sales order."
      redirect_to [:sales, @sales_order]
    else
      @sales_order.entries.build
      @customer = current_company.customers
      @quotation = current_company.quotations
      @assembly = current_company.assemblies
      @currencies = current_company.currencies
      @exchange_rate = current_company.exchange_rates
      @salesman = current_company.salesmen
      render :action => 'new'
    end
  end
  
  def edit
    @sales_order = current_company.sales_orders.find(params[:id])
    @sales_order.entries.build
    @customer = current_company.customers
    @quotation = current_company.quotations
    @assembly = current_company.assemblies
    @currencies = current_company.currencies
    @exchange_rate = current_company.exchange_rates
  end
  
  def update
    @sales_order = current_company.sales_orders.find(params[:id])
    if @sales_order.update_attributes(params[:sales_order])
      flash[:notice] = "Successfully updated sales order."
      redirect_to [:sales, @sales_order]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sales_order = current_company.sales_orders.find(params[:id])
    @sales_order.destroy
    flash[:notice] = "Successfully destroyed sales order."
    redirect_to sales_sales_orders_url
  end
  
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'so'
  end

end
