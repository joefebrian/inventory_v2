class CreateProjectWorkOrders < ActiveRecord::Migration
  def self.up
    create_table :project_work_orders do |t|
      t.integer :project_id
      t.string :number
      t.date :user_date
      t.date :valid_since
      t.date :valid_thru
      t.string :payment_term

      t.timestamps
    end
  end

  def self.down
    drop_table :project_work_orders
  end
end
