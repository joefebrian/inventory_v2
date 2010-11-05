class AddDefaultTopToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :default_top, :string
  end

  def self.down
    remove_column :customers, :default_top
  end
end
