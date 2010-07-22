class Purchasing::QuotationRequestsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @quotation_requests = current_company.quotation_requests.all
  end
  
  def show
    @quotation_request = current_company.quotation_requests.find(params[:id])
  end
  
  def new
    @quotation_request = current_company.quotation_requests.new
  end
  
  def create
    @quotation_request = current_company.quotation_requests.new(params[:quotation_request])
    if @quotation_request.save
      flash[:notice] = "Successfully created purchasing/quotation request."
      redirect_to [:purchasing, @quotation_request]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @quotation_request = current_company.quotation_requests.find(params[:id])
  end
  
  def update
    @quotation_request = current_company.quotation_requests.find(params[:id])
    if @quotation_request.update_attributes(params[:quotation_request])
      flash[:notice] = "Successfully updated quotation request."
      redirect_to [:purchasing, @quotation_request]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @quotation_request = current_company.quotation_requests.find(params[:id])
    @quotation_request.destroy
    flash[:notice] = "Successfully destroyed quotation request."
    redirect_to quotation_requests_url
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'qr'
  end
end
