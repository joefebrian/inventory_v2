class AddCurrencyIdToSalesOrder < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :currency_id, :integer
  end

  def self.down
    remove_column :sales_orders, :currency_id
  end
end
