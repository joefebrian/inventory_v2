class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource

  def index
    @users = current_company.users.paginate(:page => params[:page])
  end
  
  def show
    @user = current_company.users.find(params[:id])
  end
  
  def new
    @user = current_company.users.new
  end
  
  def create
    @user = current_company.users.new(params[:user])
    if @user.save
      flash[:notice] = "You're signed up!"
      redirect_to @user
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_company.users.find(params[:id])
  end
  
  def update
    @user = current_company.users.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = current_company.users.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end

  private
  def assign_tab
    @tab = 'administrations'
    @current = 'users'
  end
end
