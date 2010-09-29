class ChangeTopOnSalesOrders < ActiveRecord::Migration
  def self.up
    change_column :sales_orders, :top, :string
    rename_column :sales_orders, :kurs_value, :currency_rate
    remove_column :sales_orders, :kurs_id
  end

  def self.down
  end
end
