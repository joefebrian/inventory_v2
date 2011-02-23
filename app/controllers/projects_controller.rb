class ProjectsController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :through => :current_company

  def index
    @search = current_company.projects.search(params[:search])
    @projects = @search.paginate(:page => params[:page])
  end

  def show
    @project = current_company.projects.find(params[:id])
  end

  def new
    @project = current_company.projects.new
  end

  def create
    @project = current_company.projects.new(params[:project])
    if @project.save
      flash[:notice] = "Successfully created project."
      redirect_to @project
    else
      render :action => 'new'
    end
  end

  def edit
    @project = current_company.projects.find(params[:id])
  end

  def update
    @project = current_company.projects.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = current_company.projects.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end

  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
