class SalesPricesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @search = current_company.sales_prices.search(params[:search])
    @sales_prices = @search.all
  end

  private
  def assign_tab
    @tab = 'administrations'
    @current = 'hpp'
  end
end
