class SalesOrderEntry < ActiveRecord::Base
  belongs_to :sales_order
  belongs_to :item
  
  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end
end
