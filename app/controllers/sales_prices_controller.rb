class SalesPricesController < ApplicationController
  def index
    @sales_prices = SalesPrice.all
  end
end
