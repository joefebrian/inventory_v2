class MaterialRequest < ActiveRecord::Base
  attr_accessible :company_id, :number, :userdate, :reference, :requester, :description
  belongs_to :company

  validates_presence_of :number, :userdate, :reference, :requester
  validates_uniqueness_of :number, :scope => :company_id
end
