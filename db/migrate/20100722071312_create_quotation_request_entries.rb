class CreateQuotationRequestEntries < ActiveRecord::Migration
  def self.up
    create_table :quotation_request_entries do |t|
      t.integer :quotation_request_id
      t.integer :item_id
      t.integer :quantity
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :quotation_request_entries
  end
end
