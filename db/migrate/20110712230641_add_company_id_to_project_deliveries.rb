class AddCompanyIdToProjectDeliveries < ActiveRecord::Migration
  def self.up
    add_column :project_deliveries, :company_id, :integer
  end

  def self.down
    remove_column :project_deliveries, :company_id
  end
end
