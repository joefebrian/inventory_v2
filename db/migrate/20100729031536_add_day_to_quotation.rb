class AddDayToQuotation < ActiveRecord::Migration
  def self.up
    add_column :quotations, :day, :integer
  end

  def self.down
    remove_column :quotations, :day
  end
end
