class Currency < ActiveRecord::Base
  attr_accessible :company_id, :code, :name, :symbol
  belongs_to :company
  has_many :sales_orders
end
