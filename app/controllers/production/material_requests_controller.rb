module Production
  class MaterialRequestsController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :through => :current_company
    
    def index
      @search = current_company.material_requests.productions.search(params[:search])
      @material_requests = current_company.material_requests.productions.paginate(:page => params[:page])
    end

    def new
      @material_request = current_company.material_requests.productions.new
      @work_orders = current_company.work_orders
    end

    def create
      @material_request = current_company.material_requests.productions.new(params[:material_request])
      @work_orders = current_company.work_orders
      if params[:get_wo]
        @material_request.build_assembly_entries
        @material_request.description = 'Auto'
        render 'new', :layout => false and return
      end
    end

    def show
      @material_request = current_company.material_requests.productions.find(params[:id])
    end

    def confirmation
      @material_request = current_company.material_requests.productions.find(params[:id])
    end

    def confirm
      @material_request = current_company.material_requests.productions.find(params[:id])
      @material_request.closed = true
      if @material_request.save(false)
        flash[:success] = "Confirmed"
        # kurangi stock
        redirect_to production_material_requests_path
      else
        render 'confirmation'
      end
    end
    
    private
    def assign_tab
      @tab = 'transactions'
      @current = 'prod_mr'
    end
  end
end
