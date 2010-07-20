class AddTipeToAssembly < ActiveRecord::Migration
  def self.up
    add_column :assemblies, :tipe, :string
  end

  def self.down
    remove_column :assemblies, :tipe
  end
end
