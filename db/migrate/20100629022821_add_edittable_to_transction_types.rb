class AddEdittableToTransctionTypes < ActiveRecord::Migration
  def self.up
    add_column :transaction_types, :edittable, :boolean, :default => true
  end

  def self.down
    remove_column :transaction_types, :edittable
  end
end
