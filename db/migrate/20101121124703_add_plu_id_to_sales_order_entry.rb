class AddPluIdToSalesOrderEntry < ActiveRecord::Migration
  def self.up
    add_column :sales_order_entries, :plu_id, :integer
  end

  def self.down
    remove_column :sales_order_entries, :plu_id
  end
end
