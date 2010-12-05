class SalesInvoicesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @search = current_company.sales_invoices.search(params[:search])
    @sales_invoices = @search.paginate(:page => params[:page])
  end
  
  def show
    @sales_invoice = current_company.sales_invoices.find(params[:id])
  end
  
  def new
    @sales_invoice = current_company.sales_invoices.new
    @sales_invoice.due_date = Time.now.to_date
    @delivery_orders = current_company.delivery_orders
  end
  
  def create
    @sales_invoice = current_company.sales_invoices.new(params[:sales_invoice])
    if @sales_invoice.save
      flash[:notice] = "Successfully created sales invoice."
      redirect_to @sales_invoice
    else
      render :action => 'new'
    end
  end
  
  def edit
    @sales_invoice = current_company.sales_invoices.find(params[:id])
  end
  
  def update
    @sales_invoice = current_company.sales_invoices.find(params[:id])
    if @sales_invoice.update_attributes(params[:sales_invoice])
      flash[:notice] = "Successfully updated sales invoice."
      redirect_to @sales_invoice
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sales_invoice = current_company.sales_invoices.find(params[:id])
    @sales_invoice.destroy
    flash[:notice] = "Successfully destroyed sales invoice."
    redirect_to sales_invoices_url
  end
  
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'invoices'
  end

end
