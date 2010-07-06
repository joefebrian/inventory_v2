class ChangePriceListEntries < ActiveRecord::Migration
  def self.up
    rename_column :price_list_entries, :price_list, :price_list_id
  end

  def self.down
  end
end
