class AddNameToAssembly < ActiveRecord::Migration
  def self.up
    add_column :assemblies, :name, :string
  end

  def self.down
    remove_column :assemblies, :name
  end
end
