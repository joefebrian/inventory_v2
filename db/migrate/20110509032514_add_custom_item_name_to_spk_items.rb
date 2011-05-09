class AddCustomItemNameToSpkItems < ActiveRecord::Migration
  def self.up
    add_column :spk_items, :custom_item_name, :string
  end

  def self.down
    remove_column :spk_items, :custom_item_name
  end
end
