class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :company_id
      t.string :number
      t.string :name
      t.integer :customer_id
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
