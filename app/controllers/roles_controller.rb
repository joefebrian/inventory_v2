class RolesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource

  def index
    @search = current_company.roles.search(params[:search])
    @roles = @search.paginate(:page => params[:page])
  end
  
  def show
    @role = current_company.roles.find(params[:id])
  end
  
  def new
    @role = current_company.roles.new
  end
  
  def create
    @role = current_company.roles.new(params[:role])
    if @role.save
      flash[:notice] = "Successfully created role."
      redirect_to @role
    else
      render :action => 'new'
    end
  end
  
  def edit
    @role = current_company.roles.find(params[:id])
    if @role.name.downcase == 'admin'
      flash[:error] = "Admin role cannot be edited"
      redirect_to roles_path
    end
  end
  
  def update
    @role = current_company.roles.find(params[:id])
    unless @role.name.downcase == 'admin'
      @role.privileges.delete_all
      if @role.update_attributes(params[:role])
        flash[:notice] = "Successfully updated role."
      else
        render :action => 'edit' and return
      end
    end
    redirect_to @role
  end
  
  def destroy
    @role = current_company.roles.find(params[:id])
    if @role.name.downcase == "admin"
      flash[:error] = "Admin role cannot be deleted"
    else
      @role.destroy
      flash[:notice] = "Successfully destroyed role."
    end
    redirect_to roles_url
  end
  private
  def assign_tab
    @tab = 'administrations'
    @current = 'roles'
  end
end
