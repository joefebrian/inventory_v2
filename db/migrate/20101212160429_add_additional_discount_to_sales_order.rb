class AddAdditionalDiscountToSalesOrder < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :additional_discount, :integer, :default => 0
  end

  def self.down
    remove_column :sales_orders, :additional_discount
  end
end
