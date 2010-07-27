class KursRate < ActiveRecord::Base
  has_many :sales_order
  belongs_to :company
end
