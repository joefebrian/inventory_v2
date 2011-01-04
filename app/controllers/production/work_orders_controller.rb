class Production::WorkOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource :class => 'Company'

  def index
    @search = current_company.work_orders.search(params[:search])
    @work_orders = current_company.work_orders.paginate(:page => params[:page])
  end

  def new
    @work_order = current_company.work_orders.new
    @work_order.entries.build
  end

  def create
    @work_order = current_company.work_orders.new(params[:work_order])
    if @work_order.save
      flash[:notice] = "Work Order created successfully"
      redirect_to production_work_orders_path
    else
      render :action => 'new'
    end
  end

  def show
    @work_order = current_company.work_orders.find(params[:id])
  end
  
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'wo'
  end
end
