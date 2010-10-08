class RenameBeginingBalanceCategoriesTable < ActiveRecord::Migration
  def self.up
    rename_table :begining_balances_categories, :beginning_balances_categories
  end

  def self.down
  end
end
