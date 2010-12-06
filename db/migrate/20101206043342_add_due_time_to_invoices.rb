class AddDueTimeToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :due_time, :integer
  end

  def self.down
    remove_column :invoices, :due_time
  end
end
