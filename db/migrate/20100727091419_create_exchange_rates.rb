class CreateExchangeRates < ActiveRecord::Migration
  def self.up
    create_table :exchange_rates do |t|
      t.integer :company_id
      t.integer :currency_id
      t.integer :value
      t.date :effective_date
      t.timestamps
    end
  end
  
  def self.down
    drop_table :exchange_rates
  end
end
