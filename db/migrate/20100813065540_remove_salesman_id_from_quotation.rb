class RemoveSalesmanIdFromQuotation < ActiveRecord::Migration
  def self.up
    remove_column :quotations, :salesman_id
  end

  def self.down
    add_column :quotations, :salesman_id, :integer
  end
end
