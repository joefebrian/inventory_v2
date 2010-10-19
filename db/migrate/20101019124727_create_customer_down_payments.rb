class CreateCustomerDownPayments < ActiveRecord::Migration
  def self.up
    create_table :customer_down_payments do |t|
      t.integer :company_id
      t.integer :customer_id
      t.string :number
      t.string :value
      t.date :tanggal
      t.timestamps
    end
  end

  def self.down
    drop_table :customer_down_payments
  end
end
