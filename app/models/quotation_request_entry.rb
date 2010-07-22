class QuotationRequestEntry < ActiveRecord::Base
  belongs_to :quotation_request
  belongs_to :item
end
