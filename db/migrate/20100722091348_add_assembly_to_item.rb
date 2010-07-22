class AddAssemblyToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :assembly, :boolean
  end

  def self.down
    remove_column :items, :assembly
  end
end
