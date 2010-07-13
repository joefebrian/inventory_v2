class CreateAssemblies < ActiveRecord::Migration
  def self.up
    create_table :assemblies do |t|
      t.integer :company_id
      t.string :type
      t.string :number
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :assemblies
  end
end
