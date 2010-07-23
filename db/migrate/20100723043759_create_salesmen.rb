class CreateSalesmen < ActiveRecord::Migration
  def self.up
    create_table :salesmen do |t|
      t.integer :company_id
      t.integer :profile_id
      t.string :code
      t.timestamps
    end
  end
  
  def self.down
    drop_table :salesmen
  end
end
