class CreateTransAssemblies < ActiveRecord::Migration
  def self.up
    create_table :trans_assemblies do |t|
      t.integer :company_id
      t.integer :warehouse_id
      t.integer :assembly_id
      t.string :number
      t.integer :quantity
      t.date :date
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :trans_assemblies
  end
end
