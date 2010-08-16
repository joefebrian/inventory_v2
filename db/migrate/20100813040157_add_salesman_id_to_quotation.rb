class AddSalesmanIdToQuotation < ActiveRecord::Migration
  def self.up
    add_column :quotations, :salesman_id, :integer
  end

  def self.down
    remove_column :quotations, :salesman_id
  end
end
