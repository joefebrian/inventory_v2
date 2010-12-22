class CreateWorkOrders < ActiveRecord::Migration
  def self.up
    create_table :work_orders do |t|
      t.integer :company_id
      t.string :number
      t.text :remark
      t.string :requester

      t.timestamps
    end
  end

  def self.down
    drop_table :work_orders
  end
end
