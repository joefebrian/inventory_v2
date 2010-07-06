class AddPriceListIdToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :price_list_id, :integer
  end

  def self.down
    remove_column :customers, :price_list_id
  end
end
