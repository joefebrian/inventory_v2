class AddValueToCreditDebitNotes < ActiveRecord::Migration
  def self.up
    add_column :credit_debit_notes, :value, :integer
  end

  def self.down
    remove_column :credit_debit_notes, :value
  end
end
