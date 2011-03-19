class AddSalesmanIdToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :salesman_id, :integer
  end

  def self.down
    remove_column :projects, :salesman_id
  end
end
