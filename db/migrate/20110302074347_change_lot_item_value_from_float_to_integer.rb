class ChangeLotItemValueFromFloatToInteger < ActiveRecord::Migration
  def self.up
    change_column :lot_items, :value, :integer
  end

  def self.down
  end
end
