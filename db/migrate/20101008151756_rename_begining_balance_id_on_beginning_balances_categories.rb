class RenameBeginingBalanceIdOnBeginningBalancesCategories < ActiveRecord::Migration
  def self.up
    rename_column :beginning_balances_categories, :begining_balance_id, :beginning_balance_id
  end

  def self.down
  end
end
