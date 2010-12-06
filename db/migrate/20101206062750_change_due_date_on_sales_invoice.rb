class ChangeDueDateOnSalesInvoice < ActiveRecord::Migration
  def self.up
    rename_column :sales_invoices, :due_date, :due_time
    change_column :sales_invoices, :due_time, :integer
  end

  def self.down
  end
end
