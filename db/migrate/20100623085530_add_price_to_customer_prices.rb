class AddPriceToCustomerPrices < ActiveRecord::Migration
  def self.up
    add_column :customer_prices, :price, :integer
  end

  def self.down
    remove_column :customer_prices, :price
  end
end
