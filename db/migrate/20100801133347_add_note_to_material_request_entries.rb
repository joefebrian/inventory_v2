class AddNoteToMaterialRequestEntries < ActiveRecord::Migration
  def self.up
    add_column :material_request_entries, :note, :string
  end

  def self.down
    remove_column :material_request_entries, :note
  end
end
