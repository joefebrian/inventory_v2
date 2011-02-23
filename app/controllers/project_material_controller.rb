class ProjectMaterialController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :project, :through => :current_company

  def edit
    @material_request = current_company.projects.find(params[:project_id]).material_request
    @material_request.entries.build
  end

  def update
    @material_request = current_company.projects.find(params[:project_id]).material_request
    if @material_request.update_attributes(params[:material_request])
      flash[:success] = "Material updated"
      redirect_to project_material_request_path(@material_request.project)
    else
      render :action => "edit"
    end
  end
  
  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
