class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :phone
      t.string :fax
      t.timestamps
    end
  end
  
  def self.down
    drop_table :profiles
  end
end
