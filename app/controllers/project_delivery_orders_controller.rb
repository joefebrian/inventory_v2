class ProjectDeliveryOrdersController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :project, :through => :current_company
  authorize_resource

  def index
    @search = @project.project_delivery_orders.search(params[:search])
    @deliveries = @search.paginate(:page => params[:page])
  end

  def new
    @delivery = @project.project_delivery_orders.new
    @delivery.entries.build
  end

  def create
    @delivery = @project.project_delivery_orders.new(params[:project_delivery_order])
    if @delivery.save
      flash[:notice] = "Project delivery saved"
      redirect_to project_deliveries_path(@project)
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def show
  end

  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
