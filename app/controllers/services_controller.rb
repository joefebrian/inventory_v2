class ServicesController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  #before_filter :categories_list

  def index
    @search = current_company.items.services.search(params[:search])
    @services = @search.paginate(:page => params[:page])
  end

  def new
    @service = current_company.items.services.new
  end

  private
  def set_tab
    @tab = 'administrations'
    @current = 'svc'
  end

  def categories_list
    @categories_list = leaf_categories
  end
end
