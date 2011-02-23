class HppController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource :through => :current_company

  def index
    @search = current_company.hpps.search(params[:search])
    @hpps = @search.all.paginate(:page => params[:page])
  end

  private
  def assign_tab
    @tab = 'administration'
    @current = 'hpp'
  end
end
