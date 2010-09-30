class AddTotalPriceToQuotationEntry < ActiveRecord::Migration
  def self.up
    add_column :quotation_entries, :total_price, :integer
  end

  def self.down
    remove_column :quotation_entries, :total_price
  end
end
