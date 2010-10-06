class AddServiceToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :service, :boolean, :default => false
  end

  def self.down
    remove_column :categories, :service
  end
end
