class CreateBeginingBalancesCategories < ActiveRecord::Migration
  def self.up
    create_table :begining_balances_categories, :id => false do |t|
      t.integer :begining_balance_id
      t.integer :category_id
    end
  end

  def self.down
    drop_table :begining_balances_categories
  end
end
