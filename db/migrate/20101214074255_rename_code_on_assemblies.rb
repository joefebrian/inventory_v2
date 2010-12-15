class RenameCodeOnAssemblies < ActiveRecord::Migration
  def self.up
  	rename_column :assemblies, :code, :item_id
  end

  def self.down
  end
end
