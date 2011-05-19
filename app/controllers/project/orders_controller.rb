class Project::OrdersController < ApplicationController
  before_filter :authenticate
  before_filter :set_tab
  load_and_authorize_resource :class => 'Project::Order', :through => :current_company

  def index
    @search = Project::Order.search(params[:search])
    @orders = @search.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @order.number = Project::Order.next_number_for_company(current_company)
  end

  def create
    @order = current_company.orders.new(params[:project_order])
    @order.number = Project::Order.next_number_for_company(current_company)
    if @order.save
      flash[:notice] = "Saved successfully"
      redirect_to project_orders_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
