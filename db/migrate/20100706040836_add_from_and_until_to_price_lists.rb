class AddFromAndUntilToPriceLists < ActiveRecord::Migration
  def self.up
    add_column :price_lists, :active_from, :date
    add_column :price_lists, :active_until, :date
  end

  def self.down
    remove_column :price_lists, :active_from
    remove_column :price_lists, :active_until
  end
end
