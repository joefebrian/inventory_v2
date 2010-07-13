class CreateKursIds < ActiveRecord::Migration
  def self.up
    create_table :kurs_ids do |t|
      t.string :code
      t.string :name
      t.string :symbol
      t.integer :company_id

      t.timestamps
    end
  end

  def self.down
    drop_table :kurs_ids
  end
end
