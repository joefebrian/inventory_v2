class CreateDownPaymentCustomers < ActiveRecord::Migration
  def self.up
    create_table :down_payment_customers do |t|
      t.integer :company_id
      t.string :number
      t.integer :customer_id
      t.integer :value
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :down_payment_customers
  end
end
