class QuotationEntry < ActiveRecord::Base
  belongs_to :quotation
  belongs_to :item
  
  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end
end
