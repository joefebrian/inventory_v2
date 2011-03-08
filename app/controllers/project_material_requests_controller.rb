class ProjectMaterialRequestsController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :project, :through => :current_company

  def index
    @material_requests = @project.material_requests.all.paginate(:page => params[:page])
  end

  def new
    @material_request = @project.material_requests.new(:company_id => @project.company_id)
    @material_request.description = "Material request for project # #{@project.number}"
    @project.materials.each do |mat|
      @material_request.entries.build(:item_id => mat.item_id, :quantity => mat.unrequested_quantity, :estimated_delivery_date => Time.now.to_date)
    end
  end

  def create
    @material_request = @project.material_requests.new(:company_id => @project.company_id)
    @material_request.attributes = params[:material_request]
    if @material_request.save
      flash[:success] = "Material request created"
      redirect_to project_material_requests_path(@project)
    else
      render :action => "new"
    end
  end

  def show
    @material_request = @project.material_requests.find(params[:id])
  end

  def edit
    @material_request = @project.material_requests.find(params[:id])
  end

  def update
    @material_request = @project.material_requests.find(params[:id])
    if @material_request.update_attributes(params[:material_request])
      flash[:success] = "Material request updated"
      redirect_to [@project, @material_request]
    else
      render :action => :edit
    end
  end
  
  def destroy
    @material_request = @project.material_requests.find(params[:id])
    @material_request.destroy
    flash[:notice] = "Material Request deleted"
    redirect_to project_material_requests_path(@project)
  end

  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
