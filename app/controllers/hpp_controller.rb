class HppController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @search = current_company.hpps.search(params[:search])
  end

  private
  def assign_tab
    @tab = 'administration'
    @current = 'hpp'
  end
end
