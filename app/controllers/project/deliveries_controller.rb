class Project
  class DeliveriesController < ApplicationController
    before_filter :authenticate
    before_filter :set_tab
    load_and_authorize_resource :spk, :through => :current_company
    load_and_authorize_resource :through => :spk, :class => "Project::Delivery", :except => [:new]

    def index
      @search = @spk.deliveries.search(params[:search])
      @deliveries = @search.paginate(:page => params[:page])
    end

    def new
      @delivery = @spk.deliveries.new
      @requests = @spk.requests
    end

    def create
      @delivery.attributes = params[:project_delivery]
      if params[:get_entries]
        @delivery.build_entries
        @requests = @spk.requests
        render :action => 'new', :layout => false and return
      else
        if @delivery.save
          flash[:notice] = "Delivery saved"
          redirect_to project_spk_deliveries_path(@spk)
        else
          render :action => 'new'
        end
      end
    end
    
    private
    def set_tab
      @tab = 'transactions'
      @current = 'prj'
    end
  end
end
