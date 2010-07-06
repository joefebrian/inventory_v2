class AddUnitIdForPriceListEntries < ActiveRecord::Migration
  def self.up
    add_column :price_list_entries, :unit_id, :integer
  end

  def self.down
    remove_column :price_list_entries, :unit_id
  end
end
