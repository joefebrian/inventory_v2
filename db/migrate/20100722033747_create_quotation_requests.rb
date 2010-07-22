class CreateQuotationRequests < ActiveRecord::Migration
  def self.up
    create_table :quotation_requests do |t|
      t.integer :company_id
      t.string :number
      t.date :request_date
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :quotation_requests
  end
end
