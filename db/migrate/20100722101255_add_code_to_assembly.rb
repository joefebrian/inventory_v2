class AddCodeToAssembly < ActiveRecord::Migration
  def self.up
    add_column :assemblies, :code, :string
  end

  def self.down
    remove_column :assemblies, :code
  end
end
