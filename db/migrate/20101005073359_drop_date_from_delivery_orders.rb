class DropDateFromDeliveryOrders < ActiveRecord::Migration
  def self.up
    remove_column :delivery_orders, :date
  end

  def self.down
  end
end
