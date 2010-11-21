class DeliveryOrderEntry < ActiveRecord::Base
  belongs_to :delivery_order
  belongs_to :item
  belongs_to :plu

  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end

end
