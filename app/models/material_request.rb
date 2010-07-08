class MaterialRequest < ActiveRecord::Base
  attr_accessible :company_id, :number, :userdate, :reference, :requester, :description
end
