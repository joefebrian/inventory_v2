class AddCompanyIdToMaterialAllocations < ActiveRecord::Migration
  def self.up
    add_column :material_allocations, :company_id, :integer
  end

  def self.down
    remove_column :material_allocations, :company_id
  end
end
