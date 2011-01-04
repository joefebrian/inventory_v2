class Purchasing::MaterialRequestsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource :class => 'Company'

  def index
    @search = current_company.material_requests.search(params[:search])
    if params[:state] == 'closed'
      @material_requests = @search.search(:closed => true).paginate(:page => params[:page])
    elsif params[:state] == 'all'
      @material_requests = @search.paginate(:page => params[:page])
    else
      @material_requests = @search.search(:closed => false).paginate(:page => params[:page])
    end
  end

  def show
    @material_request = MaterialRequest.find(params[:id])
      respond_to do |format|
        if(params[:type])
            format.html { render "print", :layout => "print"}
        else
            format.html { render "show", :layout => "application"}
        end
      end
  end

  def new
    @material_request = current_company.material_requests.new
    @material_request.entries.build
  end

  def create
    @material_request = current_company.material_requests.new(params[:material_request])
    if @material_request.save
      flash[:success] = "Successfully created material request."
      redirect_to purchasing_material_request_path(@material_request)
    else
      render :action => 'new'
    end
  end

  def edit
    @material_request = current_company.material_requests.find(params[:id])
    @material_request.entries.build
  end

  def update
    @material_request = current_company.material_requests.find(params[:id])
    if @material_request.update_attributes(params[:material_request])
      flash[:success] = "Successfully updated material request."
      redirect_to purchasing_material_request_path(@material_request)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @material_request = current_company.material_requests.find(params[:id])
    @material_request.destroy
    flash[:notice] = "Successfully destroyed material request."
    redirect_to purchasing_material_requests_path
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'mr'
  end
end

