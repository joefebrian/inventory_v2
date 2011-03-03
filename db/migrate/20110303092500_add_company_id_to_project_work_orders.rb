class AddCompanyIdToProjectWorkOrders < ActiveRecord::Migration
  def self.up
    add_column :project_work_orders, :company_id, :integer
  end

  def self.down
    remove_column :project_work_orders, :company_id
  end
end
