class AddCompanyIdToItemReceives < ActiveRecord::Migration
  def self.up
    add_column :item_receives, :company_id, :integer
  end

  def self.down
    remove_column :item_receives, :company_id
  end
end
