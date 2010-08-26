class CreateTransAssembliesEntries < ActiveRecord::Migration
  def self.up
    create_table :trans_assemblies_entries do |t|
      t.integer :trans_assembly_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :trans_assemblies_entries
  end
end
