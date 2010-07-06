class AddProfileIdToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :profile_id, :integer
  end

  def self.down
    remove_column :suppliers, :profile_id
  end
end
