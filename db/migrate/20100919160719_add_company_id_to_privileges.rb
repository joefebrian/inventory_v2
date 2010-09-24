class AddCompanyIdToPrivileges < ActiveRecord::Migration
  def self.up
    add_column :privileges, :company_id, :integer
  end

  def self.down
    remove_column :privileges, :company_id
  end
end
