class DownPaymentCustomer < ActiveRecord::Base
  attr_accessible :company_id, :number, :customer_id, :value, :description
end
