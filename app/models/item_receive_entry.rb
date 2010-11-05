class ItemReceiveEntry < ActiveRecord::Base
  belongs_to :item_receive
  belongs_to :item
  belongs_to :plu

  before_save :populate_total

  def item_name
    item.try(:name)
  end

  def item_name=(name)
  end

  def populate_total
    po_entry = item_receive.purchase_order.entries.find_by_item_id(item)
    self.total = (po_entry.total / po_entry.quantity) * quantity
  end
end
