class CreateMaterialRequests < ActiveRecord::Migration
  def self.up
    create_table :material_requests do |t|
      t.integer :company_id
      t.string :number
      t.date :userdate
      t.string :reference
      t.string :requester
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :material_requests
  end
end
