class AddPluIdToDeliveryOrderEntry < ActiveRecord::Migration
  def self.up
    add_column :delivery_order_entries, :plu_id, :integer
  end

  def self.down
    remove_column :delivery_order_entries, :plu_id
  end
end
