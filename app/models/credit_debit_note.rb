class CreditDebitNote < ActiveRecord::Base
  attr_accessible :company_id, :number, :customer_id, :supplier_id, :user_date, :note, :credit
end
