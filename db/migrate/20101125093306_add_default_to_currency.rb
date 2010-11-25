class AddDefaultToCurrency < ActiveRecord::Migration
  def self.up
    add_column :currencies, :default, :boolean
  end

  def self.down
    remove_column :currencies, :default
  end
end
