class AddRetensiToSalesOrder < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :retensi, :string
    #add_column :sales_orders, :customer_id, :integer
    add_column :sales_orders, :order_ref, :string
    add_column :sales_orders, :kurs_id, :integer
  end

  def self.down
    remove_column :sales_orders, :kurs_id
    remove_column :sales_orders, :order_ref
    #remove_column :sales_orders, :customer_id
    remove_column :sales_orders, :retensi
  end
end
