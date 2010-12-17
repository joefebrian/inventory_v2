class CreateAssemblyProgressEntries < ActiveRecord::Migration
  def self.up
    create_table :assembly_progress_entries do |t|
      t.integer :trans_assembly_id
      t.integer :assembly_id
      t.integer :quantity
      t.date :progress_date

      t.timestamps
    end
  end

  def self.down
    drop_table :assembly_progress_entries
  end
end
