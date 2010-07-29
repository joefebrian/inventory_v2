class AddPriceToQuotationEntry < ActiveRecord::Migration
  def self.up
    add_column :quotation_entries, :price, :integer
  end

  def self.down
    remove_column :quotation_entries, :price
  end
end
