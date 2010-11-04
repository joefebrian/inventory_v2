class AddClosedToSalesOrder < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :closed, :boolean
    add_column :sales_orders, :closing_note, :text
  end

  def self.down
    remove_column :sales_orders, :closing_note
    remove_column :sales_orders, :closed
  end
end
