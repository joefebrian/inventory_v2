class CreateQuotationRequestsSuppliers < ActiveRecord::Migration
  def self.up
    create_table :quotation_requests_suppliers, :id => false do |t|
      t.integer :quotation_request_id
      t.integer :supplier_id

      t.timestamps
    end
  end

  def self.down
    drop_table :quotation_requests_suppliers
  end
end
