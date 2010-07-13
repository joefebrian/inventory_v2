class CreatePenawaranHargas < ActiveRecord::Migration
  def self.up
    create_table :penawaran_hargas do |t|
      t.integer :company_id
      t.string :number
      t.integer :customer_id
      t.date :tgl_berlaku
      t.string :memo
      t.text :keterangan
      t.string :nama_perlatan
      t.string :nama_proyek

      t.timestamps
    end
  end

  def self.down
    drop_table :penawaran_hargas
  end
end
