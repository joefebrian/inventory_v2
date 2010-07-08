class MaterialRequestsController < ApplicationController
  def index
    @material_requests = MaterialRequest.all
  end
  
  def show
    @material_request = MaterialRequest.find(params[:id])
  end
  
  def new
    @material_request = MaterialRequest.new
  end
  
  def create
    @material_request = MaterialRequest.new(params[:material_request])
    if @material_request.save
      flash[:notice] = "Successfully created material request."
      redirect_to @material_request
    else
      render :action => 'new'
    end
  end
  
  def edit
    @material_request = MaterialRequest.find(params[:id])
  end
  
  def update
    @material_request = MaterialRequest.find(params[:id])
    if @material_request.update_attributes(params[:material_request])
      flash[:notice] = "Successfully updated material request."
      redirect_to @material_request
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @material_request = MaterialRequest.find(params[:id])
    @material_request.destroy
    flash[:notice] = "Successfully destroyed material request."
    redirect_to material_requests_url
  end
end
