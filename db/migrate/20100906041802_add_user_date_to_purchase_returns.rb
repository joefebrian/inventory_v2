class AddUserDateToPurchaseReturns < ActiveRecord::Migration
  def self.up
    add_column :purchase_returns, :user_date, :date
  end

  def self.down
    remove_column :purchase_returns, :user_date
  end
end
