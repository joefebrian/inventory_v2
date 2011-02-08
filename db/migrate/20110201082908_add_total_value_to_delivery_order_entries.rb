class AddTotalValueToDeliveryOrderEntries < ActiveRecord::Migration
  def self.up
    add_column :delivery_order_entries, :total_value, :decimal
  end

  def self.down
    remove_column :delivery_order_entries, :total_value
  end
end
