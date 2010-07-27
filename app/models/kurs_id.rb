class KursId < ActiveRecord::Base
  validates_presence_of :code
  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :code
  has_many :sales_order
  belongs_to :company
end
