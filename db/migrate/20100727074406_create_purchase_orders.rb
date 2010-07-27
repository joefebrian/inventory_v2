class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.integer :company_id
      t.string :number
      t.integer :material_request_id
      t.integer :supplier_id
      t.text :term_of_payment
      t.date :po_date
      t.string :attention
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
