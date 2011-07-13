class AddAllocatableTypeToMaterialAllocations < ActiveRecord::Migration
  def self.up
    add_column :material_allocations, :allocatable_type, :string
  end

  def self.down
    remove_column :material_allocations, :allocatable_type
  end
end
