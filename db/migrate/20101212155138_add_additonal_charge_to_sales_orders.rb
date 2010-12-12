class AddAdditonalChargeToSalesOrders < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :additional_charge, :integer
  end

  def self.down
    remove_column :sales_orders, :additional_charge
  end
end
