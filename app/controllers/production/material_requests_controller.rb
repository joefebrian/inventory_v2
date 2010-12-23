class Production::MaterialRequestsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  
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
  
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'prod_mr'
  end
end
