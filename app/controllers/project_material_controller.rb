class ProjectMaterialController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :project, :through => :current_company

  def edit
    @project.material_request.entries.build
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:success] = "Material updated"
      redirect_to project_path(@project)
    else
      @project.material_request.entries.build
      render :action => "edit"
    end
  end
  
  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
