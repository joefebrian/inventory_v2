class CreateProjectOrders < ActiveRecord::Migration
  def self.up
    create_table :project_orders do |t|
      t.string :number
      t.datetime :valid_from
      t.datetime :valid_until
      t.string :payment_terms
      t.integer :customer_id
      t.string :name
      t.text :description
      t.integer :discount
      t.integer :rounding
      t.integer :company_id

      t.timestamps
    end
  end

  def self.down
    drop_table :project_orders
  end
end
