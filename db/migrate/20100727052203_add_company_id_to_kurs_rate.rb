class AddCompanyIdToKursRate < ActiveRecord::Migration
  def self.up
    add_column :kurs_rates, :company_id, :integer
  end

  def self.down
    remove_column :kurs_rates, :company_id
  end
end
