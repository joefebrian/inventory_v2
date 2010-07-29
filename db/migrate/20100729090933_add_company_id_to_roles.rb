class AddCompanyIdToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :company_id, :integer
  end

  def self.down
    remove_column :roles, :company_id
  end
end
