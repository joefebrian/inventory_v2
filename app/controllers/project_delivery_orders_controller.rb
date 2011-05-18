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
