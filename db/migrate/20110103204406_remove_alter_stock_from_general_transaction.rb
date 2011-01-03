class RemoveAlterStockFromGeneralTransaction < ActiveRecord::Migration
  def self.up
    remove_column :transactions, :alter_stock
  end

  def self.down
    add_column :transactions, :alter_stock, :boolean, :default => true
  end
end
