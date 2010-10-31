class Purchasing::InvoicesController < ApplicationController
before_filter :authenticate
before_filter :assign_tab
  def index
    @search = current_company.invoices.search(params[:search])
    @invoices = @search.paginate(:page => params[:page])
  end
  
  def new
    @invoice = current_company.invoices.new
    @item_receives = current_company.item_receives.unconfirmed
  end

  def create
    @invoice = current_company.invoices.new(params[:invoice])
    if @invoice.save
      flash[:success] = "Purchase invoice created successfuly"
      redirect_to [:purchasing, @invoice]
    else
      @item_receives = current_company.item_receives.unconfirmed
      render :action => 'new'
    end
  end

  def show
    @invoice = current_company.invoices.find(params[:id])
  end

  def destroy
    @invoice = current_company.invoices.find(params[:id])
    @invoice.delete
    flash[:notice] = "Purchase Invoice #{@invoice.number} deleted"
    redirect_to purchasing_invoices_path
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'pinv'
  end
end
