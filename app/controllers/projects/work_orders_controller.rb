module Projects
  class WorkOrdersController < ApplicationController
    load_and_authorize_resource :project, :through => :current_company
    #load_and_authorize_resource :work_order, :through => :project
    before_filter :set_tab
    before_filter :authenticate

    def index
      @work_orders = @project.work_orders
    end

    def new
      @work_order = current_company.work_orders.new(:project_id => @project.id)
    end
    
    private
    def set_tab
      @tab = 'transactions'
      @current = 'prj'
    end
  end
end
