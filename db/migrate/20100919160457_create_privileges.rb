class CreatePrivileges < ActiveRecord::Migration
  def self.up
    create_table :privileges do |t|
      t.integer :role_id
      t.string :resource

      t.timestamps
    end
  end

  def self.down
    drop_table :privileges
  end
end
