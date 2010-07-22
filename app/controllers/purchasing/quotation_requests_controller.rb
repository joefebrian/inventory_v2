class Purchasing::QuotationRequestsController < ApplicationController
  def index
    @purchasing/quotation_requests = Purchasing::quotationRequest.all
  end
  
  def show
    @purchasing/quotation_request = Purchasing::quotationRequest.find(params[:id])
  end
  
  def new
    @purchasing/quotation_request = Purchasing::quotationRequest.new
  end
  
  def create
    @purchasing/quotation_request = Purchasing::quotationRequest.new(params[:purchasing/quotation_request])
    if @purchasing/quotation_request.save
      flash[:notice] = "Successfully created purchasing/quotation request."
      redirect_to @purchasing/quotation_request
    else
      render :action => 'new'
    end
  end
  
  def edit
    @purchasing/quotation_request = Purchasing::quotationRequest.find(params[:id])
  end
  
  def update
    @purchasing/quotation_request = Purchasing::quotationRequest.find(params[:id])
    if @purchasing/quotation_request.update_attributes(params[:purchasing/quotation_request])
      flash[:notice] = "Successfully updated purchasing/quotation request."
      redirect_to @purchasing/quotation_request
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @purchasing/quotation_request = Purchasing::quotationRequest.find(params[:id])
    @purchasing/quotation_request.destroy
    flash[:notice] = "Successfully destroyed purchasing/quotation request."
    redirect_to purchasing/quotation_requests_url
  end
end
