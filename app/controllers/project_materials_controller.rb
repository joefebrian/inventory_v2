class ProjectMaterialsController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :project, :through => :current_company

  def index
    @project.materials.build
  end

  def create
    if @project.update_attributes(params[:project])
      flash[:success] = "Material updated"
      redirect_to project_path(@project)
    else
      @project.materials.build
      render :action => "index"
    end
  end
  
  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
