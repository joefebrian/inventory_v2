class AddCompanyIdToQuotation < ActiveRecord::Migration
  def self.up
    add_column :quotations, :company_id, :string
  end

  def self.down
    remove_column :quotations, :company_id
  end
end
