class Currency < ActiveRecord::Base
  attr_accessible :company_id, :code, :name, :symbol
  belongs_to :company
  has_many :sales_orders
  has_many :exchane_rates
  
  validates_presence_of :name, :code, :symbol
  validates_uniqueness_of :name, :code, :symbol
end
