class ProjectWorkOrderController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :project, :through => :current_company
  
  def edit
    _init_work_order
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:success] = "SPK updated"
      redirect_to project_work_order_path(@project)
    else
      render :action => "edit"
    end
  end

  def show
    _init_work_order
  end

  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end

  def _init_work_order
    if @project.work_order.nil?
      wo = current_company.project_work_orders.new(:project_id => @project.id, :user_date => Time.now.to_date)
      wo.save(false)
      @project.reload
    end
  end
end
