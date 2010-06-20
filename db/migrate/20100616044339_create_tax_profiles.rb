class CreateTaxProfiles < ActiveRecord::Migration
  def self.up
    create_table :tax_profiles do |t|
      t.integer :customer_id
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :postal_code
      t.string :npwp_number
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tax_profiles
  end
end
