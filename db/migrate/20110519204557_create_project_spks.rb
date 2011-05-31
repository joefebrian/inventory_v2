class CreateProjectSpks < ActiveRecord::Migration
  def self.up
    create_table :project_spks do |t|
      t.integer :company_id
      t.string :number
      t.string :name
      t.integer :customer_id
      t.integer :salesman_id
      t.text :term_of_payment
      t.date :valid_from
      t.date :valid_thru
      t.integer :discount
      t.integer :rounding

      t.timestamps
    end
  end

  def self.down
    drop_table :project_spks
  end
end
