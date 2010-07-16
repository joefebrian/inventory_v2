class CreateAssemblyEntries < ActiveRecord::Migration
  def self.up
    create_table :assembly_entries do |t|
      t.integer :assembly_id
      t.string :item_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :assembly_entries
  end
end
