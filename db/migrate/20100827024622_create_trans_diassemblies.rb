class CreateTransDiassemblies < ActiveRecord::Migration
  def self.up
    create_table :trans_diassemblies do |t|
      t.integer :company_id
      t.integer :warehouse_id
      t.integer :trans_assembly_id
      t.string :number
      t.integer :quantity
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :trans_diassemblies
  end
end
