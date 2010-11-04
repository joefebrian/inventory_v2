class DropDownPaymentCustomer < ActiveRecord::Migration
  def self.down
    drop_table :down_payment_customers
  end
end
