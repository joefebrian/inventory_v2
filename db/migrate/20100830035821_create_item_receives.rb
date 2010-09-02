class CreateItemReceives < ActiveRecord::Migration
  def self.up
    create_table :item_receives do |t|
      t.integer :purchase_order_id
      t.string :number
      t.date :user_date
      t.string :remark
      t.timestamps
    end
  end
  
  def self.down
    drop_table :item_receives
  end
end
