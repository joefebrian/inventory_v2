class ChnageEdittableOnTransactionTypes < ActiveRecord::Migration
  def self.up
    rename_column :transaction_types, :edittable, :editable
  end

  def self.down
  end
end
