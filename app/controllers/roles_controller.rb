class RolesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource

  def index
    @roles = current_company.roles.all
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
  end
  
  def update
    @role = current_company.roles.find(params[:id])
    if @role.update_attributes(params[:role])
      flash[:notice] = "Successfully updated role."
      redirect_to @role
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @role = current_company.roles.find(params[:id])
    @role.destroy
    flash[:notice] = "Successfully destroyed role."
    redirect_to roles_url
  end
  private
  def assign_tab
    @tab = 'administrations'
    @current = 'roles'
  end
end
