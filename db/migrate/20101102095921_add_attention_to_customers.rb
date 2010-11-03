class AddAttentionToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :attention, :string
  end

  def self.down
    remove_column :customers, :attention
  end
end
