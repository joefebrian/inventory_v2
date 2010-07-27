class AddKursValueToSalesOrder < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :kurs_value, :integer
  end

  def self.down
    remove_column :sales_orders, :kurs_value
  end
end
