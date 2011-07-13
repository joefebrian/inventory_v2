class AddTransactionTypeToMaterialAllocations < ActiveRecord::Migration
  def self.up
    add_column :material_allocations, :transaction_type, :string
  end

  def self.down
    remove_column :material_allocations, :transaction_type
  end
end
