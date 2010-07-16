class CreateQuotationEntries < ActiveRecord::Migration
  def self.up
    create_table :quotation_entries do |t|
      t.integer :quotation_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :quotation_entries
  end
end
