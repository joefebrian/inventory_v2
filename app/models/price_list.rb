class PriceList < ActiveRecord::Base
  belongs_to :company
  has_many :price_list_entries

  validates_presence_of :code
  validates_presence_of :name
  validates_uniqueness_of :code, :scope => :company_id
  validates_uniqueness_of :name, :scope => :company_id

  accepts_nested_attributes_for :price_list_entries,
    :allow_destroy => true,
    :reject_if => lambda { |at| at['value'].blank? }
end
