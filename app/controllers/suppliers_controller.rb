class SuppliersController < ApplicationController
  before_filter :authenticate
  before_filter :set_tab
  load_and_authorize_resource

  def index
    @search = current_company.suppliers.search(params[:search])
    @suppliers = @search.all(:order => :name).paginate(:page => params[:page])
  end
  
  def show
    @supplier = Supplier.find(params[:id])
    render :layout => false if request.xhr?
  end
  
  def new
    @supplier = current_company.suppliers.new
    @supplier.build_profile
    render :layout => false if request.xhr?
  end
  
  def create
    @supplier = current_company.suppliers.new(params[:supplier])
    if @supplier.save
      flash[:success] = "Successfully created supplier."
      xhr_success_response
    else
      xhr_fail_response
    end
  end
  
  def edit
    @supplier = Supplier.find(params[:id])
    @supplier.build_profile if @supplier.profile.blank?
    render :layout => false if request.xhr?
  end
  
  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:success] = "Successfully updated supplier."
      xhr_success_response
    else
      xhr_fail_response
    end
  end
  
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    flash[:notice] = "Successfully destroyed supplier."
    redirect_to suppliers_url
  end

  private
  def set_tab
    @tab = "administrations"
    @current = 'sup'
  end

  def xhr_success_response
    if request.xhr?
      render :json => { 'location' => suppliers_path}.to_json, :layout => false
    else
      redirect_to @supplier
    end
  end

  def xhr_fail_response
    if request.xhr?
      form = render_to_string :action => 'new', :layout => false
      status = 'validation error'
      render :json => {'status' => status, 'form' => form }.to_json
    else
      render :action => 'edit'
    end
  end
end
