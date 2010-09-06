class CreateTransDiassembliesEntries < ActiveRecord::Migration
  def self.up
    create_table :trans_diassemblies_entries do |t|
      t.integer :trans_diassembly_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :trans_diassemblies_entries
  end
end
