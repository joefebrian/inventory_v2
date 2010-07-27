class ExchangeRate < ActiveRecord::Base
  attr_accessible :company_id, :currency_id, :value, :effective_date
end
