class CreateDetailAssemblies < ActiveRecord::Migration
  def self.up
    create_table :detail_assemblies do |t|
      t.integer :assembly_id
      t.integer :company_id
      t.integer :item_id
      t.string :qty

      t.timestamps
    end
  end

  def self.down
    drop_table :detail_assemblies
  end
end
