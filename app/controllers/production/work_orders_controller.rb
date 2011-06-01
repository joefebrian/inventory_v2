module Production
  class WorkOrdersController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :through => :current_company

    def index
      if params[:project_id]
        @project = current_company.projects.find(params[:project_id])
        @search = @project.work_orders.search(params[:search])
        @work_orders = @project.work_orders
        render "index_with_project"
      else
        @search = current_company.work_orders.search(params[:search])
        @work_orders = current_company.work_orders.paginate(:page => params[:page])
      end
    end

    def new
      if params[:project_id]
        @project = current_company.projects.find(params[:project_id])
        @work_order = @project.work_orders.new(:company_id => current_company.id, :remark => "Work Order for Project # #{@project.number} materials")
        @project.materials.item_assembly_is(true).each do |mt|
          @work_order.entries.build(:quantity => mt.value, :item_id => mt.item_id)
        end
      else
        @work_order = current_company.work_orders.new
        @work_order.entries.build
      end
    end

    def create
      @work_order = current_company.work_orders.new(params[:work_order])
      if @work_order.save
        flash[:notice] = "Work Order created successfully"
        if @work_order.project
          redirect_to project_work_orders_path(@work_order.project)
        else
          redirect_to production_work_orders_path
        end
      else
        render :action => 'new'
      end
    end

    def show
      @work_order = current_company.work_orders.find(params[:id])
    end

    def destroy
      @work_order = current_company.work_orders.find(params[:id])
      @work_order.destroy
      flash[:notice] = "Work Order successfully deleted"
      redirect_to production_work_orders_path
    end
    
    private
    def assign_tab
      @tab = 'transactions'
      @current = 'wo'
    end
  end
end
