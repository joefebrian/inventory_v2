class AddCategoryIdToAssembly < ActiveRecord::Migration
  def self.up
    add_column :assemblies, :category_id, :integer
  end

  def self.down
    remove_column :assemblies, :category_id
  end
end
