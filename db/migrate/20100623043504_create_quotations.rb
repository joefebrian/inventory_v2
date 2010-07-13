class CreateQuotations < ActiveRecord::Migration
  def self.up
    create_table :quotations do |t|
      t.string :number
      t.integer :company_id
      t.integer :customer_id
      t.date :tgl_berlaku
      t.string :hal
      t.string :memo
      t.text :keterngan
      t.string :penerima
      t.string :nama_perlatan
      t.string :nama_proyek

      t.timestamps
    end
  end

  def self.down
    drop_table :quotations
  end
end
