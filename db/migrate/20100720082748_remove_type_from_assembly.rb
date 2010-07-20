class RemoveTypeFromAssembly < ActiveRecord::Migration
  def self.up
    remove_column :assemblies, :type
  end

  def self.down
    add_column :assemblies, :type, :string
  end
end
