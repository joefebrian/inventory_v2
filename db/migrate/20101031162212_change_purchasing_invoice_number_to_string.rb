class ChangePurchasingInvoiceNumberToString < ActiveRecord::Migration
  def self.up
    change_column :invoices, :number, :string
  end

  def self.down
  end
end
