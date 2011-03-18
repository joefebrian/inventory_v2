class ProjectWorkOrderController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :project, :through => :current_company
  
  def edit
    _init_spk
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:success] = "SPK updated"
      redirect_to project_spk_path(@project)
    else
      render :action => "edit"
    end
  end

  def show
    _init_spk
  end

  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end

  def _init_spk
    if @project.spk.nil?
      wo = current_company.project_work_orders.new(:project_id => @project.id, :user_date => Time.now.to_date, :valid_since => Time.now, :valid_thru => Time.now)
      wo.save(false)
      @project.reload
    end
  end
end
