class AddDiskonToSalesReturnEntry < ActiveRecord::Migration
  def self.up
    add_column :sales_return_entries, :diskon, :integer
  end

  def self.down
    remove_column :sales_return_entries, :diskon
  end
end
