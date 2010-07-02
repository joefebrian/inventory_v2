class CreatePriceLists < ActiveRecord::Migration
  def self.up
    create_table :price_lists do |t|
      t.integer :company_id
      t.string :code
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :price_lists
  end
end
