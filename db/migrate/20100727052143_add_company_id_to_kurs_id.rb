class AddCompanyIdToKursId < ActiveRecord::Migration
  def self.up
    add_column :kurs_ids, :company_id, :integer
  end

  def self.down
    remove_column :kurs_ids, :company_id
  end
end
