class CreateCreditDebitNotes < ActiveRecord::Migration
  def self.up
    create_table :credit_debit_notes do |t|
      t.integer :company_id
      t.string :number
      t.integer :customer_id
      t.integer :supplier_id
      t.date :user_date
      t.text :note
      t.boolean :credit
      t.timestamps
    end
  end

  def self.down
    drop_table :credit_debit_notes
  end
end
