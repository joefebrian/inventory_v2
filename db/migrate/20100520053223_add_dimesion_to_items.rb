class AddDimesionToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :length, :integer
    add_column :items, :width, :integer
    add_column :items, :height, :integer
    add_column :items, :weight, :integer
  end

  def self.down
    remove_column :items, :weight
    remove_column :items, :height
    remove_column :items, :width
    remove_column :items, :length
  end
end
