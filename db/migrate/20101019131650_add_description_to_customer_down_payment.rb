class AddDescriptionToCustomerDownPayment < ActiveRecord::Migration
  def self.up
    add_column :customer_down_payments, :description, :text
  end

  def self.down
    remove_column :customer_down_payments, :description
  end
end
