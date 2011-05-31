class ChangeTransAssemblyIdToItemIdOnTransDiasseblies < ActiveRecord::Migration
  def self.up
    rename_column :trans_diassemblies, :trans_assembly_id, :assembly_id
  end

  def self.down
    rename_column :trans_diassemblies, :assembly_id, :trans_assembly_id
  end
end
