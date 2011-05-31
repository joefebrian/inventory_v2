class CreateProjectBaseMaterials < ActiveRecord::Migration
  def self.up
    create_table :project_base_materials do |t|
      t.integer :spk_id
      t.integer :item_id
      t.string :custom_item_name
      t.integer :price
      t.integer :quantity
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :project_base_materials
  end
end
