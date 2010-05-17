class AddValueToUnits < ActiveRecord::Migration
  def self.up
    add_column :units, :value, :integer
  end

  def self.down
    remove_column :units, :value
  end
end
