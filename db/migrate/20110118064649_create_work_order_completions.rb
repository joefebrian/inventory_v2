class CreateWorkOrderCompletions < ActiveRecord::Migration
  def self.up
    create_table :work_order_completions do |t|
      t.integer :work_order_id
      t.integer :assembly_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :work_order_completions
  end
end
