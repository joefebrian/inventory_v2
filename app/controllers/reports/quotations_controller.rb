class Reports::QuotationsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @search = current_company.quotations.search(params[:search])
    @quotations = @search.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.pdf
    end
  end

  private
  def assign_tab
    @tab = 'reports'
    @current = 'quot'
  end

end
