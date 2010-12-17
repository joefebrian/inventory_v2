class ChangeAssemblyIdOnAssemblyProgressEntries < ActiveRecord::Migration
  def self.up
    rename_column :assembly_progress_entries, :assembly_id, :assembly_entry_id
  end

  def self.down
    rename_column :assembly_progress_entries, :assembly_entry_id, :assembly_id
  end
end
