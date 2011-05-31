class AddRemarkToProjectDeliveries < ActiveRecord::Migration
  def self.up
    add_column :project_deliveries, :remark, :text
  end

  def self.down
    remove_column :project_deliveries, :remark
  end
end
