class AddAllocatableIdToMaterialAllocations < ActiveRecord::Migration
  def self.up
    add_column :material_allocations, :allocatable_id, :integer
  end

  def self.down
    remove_column :material_allocations, :allocatable_id
  end
end
