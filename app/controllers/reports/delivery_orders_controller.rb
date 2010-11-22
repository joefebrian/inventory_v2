class Reports::DeliveryOrdersController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @search = current_company.delivery_orders.search(params[:search])
    @delivery_orders = @search.paginate(:page => params[:page])
 
    respond_to do |format|
      format.html
      format.pdf
    end
  end

  private
  def assign_tab
    @tab = 'reports'
    @current = 'do'
  end

end
