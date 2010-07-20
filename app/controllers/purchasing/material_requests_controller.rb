class Purchasing::MaterialRequestsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  def index
    @material_requests = current_company.material_requests.all
  end
  
  def show
    @material_request = MaterialRequest.find(params[:id])
  end
  
  def new
    @material_request = current_company.material_requests.new
    @material_request.number = MaterialRequest.suggested_number
    @material_request.entries.build
  end
  
  def create
    @material_request = current_company.material_requests.new(params[:material_request])
    if @material_request.save
      flash[:notice] = "Successfully created material request."
      redirect_to purchasing_material_request_path(@material_request)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @material_request = current_company.material_requests.find(params[:id])
    @material_request.entries.build
  end
  
  def update
    @material_request = current_company.material_requests.find(params[:id])
    if @material_request.update_attributes(params[:material_request])
      flash[:notice] = "Successfully updated material request."
      redirect_to purchasing_material_request_path(@material_request)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @material_request = current_company.material_requests.find(params[:id])
    @material_request.destroy
    flash[:notice] = "Successfully destroyed material request."
    redirect_to purchasing_material_requests_path
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'mr'
  end
end
