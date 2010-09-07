class CreatePurchaseReturns < ActiveRecord::Migration
  def self.up
    create_table :purchase_returns do |t|
      t.integer :company_id
      t.string :number
      t.integer :supplier_id
      t.integer :purchase_order_id
      t.string :remark
      t.timestamps
    end
  end
  
  def self.down
    drop_table :purchase_returns
  end
end
