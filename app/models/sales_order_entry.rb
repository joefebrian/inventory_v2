class SalesOrderEntry < ActiveRecord::Base
  belongs_to :sales_order
  belongs_to :item
  belongs_to :plu
  
  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end

  def update_delivered
    delivered = sales_order.delivery_orders.collect { |d| d.entries.all(:conditions => { :item_id => item_id }) }.flatten.sum(&:quantity)
    update_attributes(:delivered_quantity => delivered)
  end

  def undelivered_quantity
    quantity - delivered_quantity
  end
end
