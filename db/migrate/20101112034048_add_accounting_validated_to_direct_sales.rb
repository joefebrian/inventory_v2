class AddAccountingValidatedToDirectSales < ActiveRecord::Migration
  def self.up
    add_column :direct_sales, :accounting_validated, :boolean
  end

  def self.down
    remove_column :direct_sales, :accounting_validated
  end
end
