class AddDiscountToProjectWorkOrders < ActiveRecord::Migration
  def self.up
    add_column :project_work_orders, :discount, :decimal
    add_column :project_work_orders, :rounding, :decimal
  end

  def self.down
    remove_column :project_work_orders, :rounding
    remove_column :project_work_orders, :discount
  end
end
