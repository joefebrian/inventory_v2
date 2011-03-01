class CreateLotItems < ActiveRecord::Migration
  def self.up
    create_table :lot_items do |t|
      t.integer :project_id
      t.string :title
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :lot_items
  end
end
