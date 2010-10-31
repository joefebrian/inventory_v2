class CreateInvoicesItemReceivesTable < ActiveRecord::Migration
  def self.up
    create_table "invoices_item_receives", :id => false do |t|
      t.integer :invoice_id
      t.integer :item_receive_id
    end
  end

  def self.down
  end
end
