class CreateQuotations < ActiveRecord::Migration
  def self.up
    create_table :quotations do |t|
      t.string :number
      t.date :tanggal_berlaku
      t.integer :customer_id
      t.string :hal
      t.string :penerima
      t.string :nama_proyek_customer
      t.text :keterangan

      t.timestamps
    end
  end

  def self.down
    drop_table :quotations
  end
end
