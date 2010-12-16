class ChangeItemIdOnTransAssembliesEntry < ActiveRecord::Migration
  def self.up
    rename_column :trans_assemblies_entries, :item_id, :assembly_id
  end

  def self.down
    rename_column :trans_assemblies_entries, :assembly_id, :item_id
  end
end
