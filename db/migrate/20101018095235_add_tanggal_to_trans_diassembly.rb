class AddTanggalToTransDiassembly < ActiveRecord::Migration
  def self.up
    add_column :trans_diassemblies, :tanggal, :date
  end

  def self.down
    remove_column :trans_diassemblies, :tanggal
  end
end
