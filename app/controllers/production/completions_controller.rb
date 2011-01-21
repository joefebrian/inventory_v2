module Production
  class CompletionsController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :work_order, :through => :current_company
    load_and_authorize_resource :completion, :through => :work_order, :class => "WorkOrderCompletion"

    def index
      @work_order = current_company.work_orders.find(params[:work_order_id])
    end

    def new
      @work_order = current_company.work_orders.find(params[:work_order_id])
      @work_order.entries.each do |entry|
        @work_order.completions.build(:assembly_id => entry.assembly_id, :quantity => 0) unless entry.complete?
      end
    end

    def create
      @work_order = current_company.work_orders.find(params[:work_order_id])
      if @work_order.update_attributes(params[:work_order])
        flash[:success] = "Progress saved"
        redirect_to production_work_order_completions_path(@work_order)
      else
        render :action => :new
      end
    end
    
    private
    def assign_tab
      @tab = 'transactions'
      @current = 'prod_completion'
    end
  end
end
