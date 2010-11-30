class ExchangeRate < ActiveRecord::Base
  attr_accessible :company_id, :currency_id, :value, :effective_date
  
  belongs_to :company
  belongs_to :currency
  
  validates_presence_of :value, :effective_date
  
  def tgl_active
   effective_date = Chronic.parse(effective_date)
  end
  
end
