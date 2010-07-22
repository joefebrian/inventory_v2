class QuotationRequestEntry < ActiveRecord::Base
  belongs_to :quotation_request
  belongs_to :item

  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end
end
