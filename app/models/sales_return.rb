class SalesReturn < ActiveRecord::Base
  attr_accessible :company_id, :number, :tanggal, :customer_id, :description
end
