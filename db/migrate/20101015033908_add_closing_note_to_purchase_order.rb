class AddClosingNoteToPurchaseOrder < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :closing_note, :string
  end

  def self.down
    remove_column :purchase_orders, :closing_note
  end
end
