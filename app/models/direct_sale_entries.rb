class DirectSaleEntries < ActiveRecord::Base
  
  belongs_to :direct_sale
  belongs_to :item

  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end

end
