class MaterialRequest < ActiveRecord::Base
  attr_accessible :company_id, :number, :userdate, :reference, :requester, :description, :entries_attributes
  belongs_to :company
  has_many :entries, :class_name => "MaterialRequestEntry"

  validates_presence_of :number, :userdate, :reference, :requester
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att['item_id'].blank? || att['quantity'].blank? }
end
