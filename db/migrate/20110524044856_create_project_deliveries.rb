class CreateProjectDeliveries < ActiveRecord::Migration
  def self.up
    create_table :project_deliveries do |t|
      t.integer :spk_id
      t.string :number
      t.date :delivery_date

      t.timestamps
    end
  end

  def self.down
    drop_table :project_deliveries
  end
end
