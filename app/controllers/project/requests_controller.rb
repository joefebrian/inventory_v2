class Project
  class RequestsController < ApplicationController
    before_filter :authenticate
    before_filter :set_tab
    load_and_authorize_resource :spk, :class => "Project::Spk", :through => :current_company
    load_and_authorize_resource :request, :class => "Project::MaterialRequest", :through => :spk

    def index
      @search = @spk.requests.search(params[:search])
      @requests = @search.paginate(:page => params[:page])
    end

    def show
    end

    def new
      @request.entries.build
    end

    def create
      @request = @spk.requests.build
      @request.attributes = params[:project_material_request]
      if @request.save
        flash[:notice] = "Material request saved"
        redirect_to project_spk_request_path(@spk, @request)
      else
        render :action => 'new'
      end
    end

    def edit
      @request.entries.build
    end

    def update
      if @request.update_attributes(params[:project_material_request])
        flash[:notice] = "Material Request updated"
        redirect_to project_spk_request_path(@spk, @request)
      else
        render :action => 'edit'
      end
    end

    def destroy
      @request.destroy
      flash[:notice] = "Material request deleted"
      redirect_to project_spk_requests_path(@spk)
    end
    private
    def set_tab
      @tab = 'transactions'
      @current = 'prj'
    end
  end
end
