class AddSalesmanIdToSalesOrder < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :salesman_id, :integer
  end

  def self.down
    remove_column :sales_orders, :salesman_id
  end
end
