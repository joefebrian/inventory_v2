class AddDiscountToQuotationEntry < ActiveRecord::Migration
  def self.up
    add_column :quotation_entries, :discount, :integer
    add_column :quotation_entries, :description, :text
  end

  def self.down
    remove_column :quotation_entries, :description
    remove_column :quotation_entries, :discount
  end
end
