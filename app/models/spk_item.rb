class SpkItem < ActiveRecord::Base
  belongs_to :project_work_order
  belongs_to :item

  #validates_presence_of :project_work_order_id
  validates_presence_of :item_name
  validates_presence_of :unit_price
  validates_numericality_of :unit_price
  validates_numericality_of :quantity, :allow_nil => true

  def item_name=(name)
    _item = Item.find_by_name(name)
    if _item
      self.item_id = _item.id
    else
      self.custom_item_name = name
    end
  end

  def item_name
    item.try(:name) || custom_item_name
  end
end
