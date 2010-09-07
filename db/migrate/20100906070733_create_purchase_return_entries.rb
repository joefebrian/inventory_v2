class CreatePurchaseReturnEntries < ActiveRecord::Migration
  def self.up
    create_table :purchase_return_entries do |t|
      t.integer :purchase_return_id
      t.integer :plu_id
      t.integer :quantity
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_return_entries
  end
end
