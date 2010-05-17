class AddActiveToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :active, :boolean
    add_column :items, :is_stock, :boolean
  end

  def self.down
    remove_column :items, :is_stock
    remove_column :items, :active
  end
end
