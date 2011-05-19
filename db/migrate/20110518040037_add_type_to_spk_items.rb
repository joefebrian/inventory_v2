class AddTypeToSpkItems < ActiveRecord::Migration
  def self.up
    add_column :spk_items, :type, :string
  end

  def self.down
    remove_column :spk_items, :type
  end
end
