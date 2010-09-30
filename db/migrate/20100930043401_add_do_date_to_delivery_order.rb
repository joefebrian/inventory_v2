class AddDoDateToDeliveryOrder < ActiveRecord::Migration
  def self.up
    add_column :delivery_orders, :do_date, :date
  end

  def self.down
    remove_column :delivery_orders, :do_date
  end
end
