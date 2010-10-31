class Purchasing::InvoicesController < ApplicationController
before_filter :authenticate
before_filter :assign_tab
  def index
    @search = current_company.invoices.search(params[:search])
    @invoices = @search.paginate(:page => params[:page])
  end
  
  def new
    @invoice = current_company.invoices.new
    @item_receives = current_company.item_receives.all_confirmed.reject { |ir| ir.invoices.present? }
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

  def edit
    @invoice = current_company.invoices.find(params[:id])
  end

  def update
    @invoice = current_company.invoices.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      flash[:success] = "Purchase invoice # #{@invoice.number} updated"
      redirect_to [:purchasing, @invoice]
    else
      render :action => 'edit'
    end
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
