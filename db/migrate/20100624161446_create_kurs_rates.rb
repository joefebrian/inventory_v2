class CreateKursRates < ActiveRecord::Migration
  def self.up
    create_table :kurs_rates do |t|
      t.string :code
      t.string :name
      t.integer :value
      t.date :tgl_berlaku

      t.timestamps
    end
  end

  def self.down
    drop_table :kurs_rates
  end
end
