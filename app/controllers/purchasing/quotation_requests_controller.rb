class Purchasing::QuotationRequestsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource :class => 'Company'

  def index
    @search = current_company.quotation_requests.search(params[:search])
    @quotation_requests = @search.paginate(:page => params[:page])
  end

  def show
    @quotation_request = current_company.quotation_requests.find(params[:id])
    flash[:notice] = "This quotation request doesn't have intended suppliers, edit this quotation request to add suppliers" if @quotation_request.suppliers.blank?
      respond_to do |format|
        if(params[:type])
            format.html { render "print", :layout => "print"}
        else
            format.html { render "show", :layout => "application"}
        end
      end
  end

  def new
    @quotation_request = current_company.quotation_requests.new
    @quotation_request.entries.build
    @suppliers = current_company.suppliers.all(:order => :name)
  end

  def create
    @quotation_request = current_company.quotation_requests.new(params[:quotation_request])
    if @quotation_request.save
      flash[:success] = "Successfully created purchasing/quotation request."
      redirect_to [:purchasing, @quotation_request]
    else
      @quotation_request.entries.build
      render :action => 'new'
    end
  end

  def edit
    @quotation_request = current_company.quotation_requests.find(params[:id])
    @quotation_request.entries.build
  end

  def update
    @quotation_request = current_company.quotation_requests.find(params[:id])
    if @quotation_request.update_attributes(params[:quotation_request])
      flash[:success] = "Successfully updated quotation request."
      redirect_to [:purchasing, @quotation_request]
    else
      @quotation_request.entries.build
      render :action => 'edit'
    end
  end

  def destroy
    @quotation_request = current_company.quotation_requests.find(params[:id])
    @quotation_request.destroy
    flash[:notice] = "Successfully destroyed quotation request."
    redirect_to purchasing_quotation_requests_url
  end

  def send_request
    @quotation_request = current_company.quotation_requests.find(params[:id])
    for supplier in @quotation_request.suppliers
      PurchasingMailer.deliver_quotation_request(@quotation_request, supplier)
    end
    flash[:notice] = "Quotation request sent"
    redirect_to [:purchasing, @quotation_request]
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'qr'
  end
end

