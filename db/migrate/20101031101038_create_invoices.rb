class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :company_id
      t.integer :number
      t.date :user_date
      t.text :remark

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
