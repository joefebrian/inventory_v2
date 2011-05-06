class SpkItem < ActiveRecord::Base
  belongs_to :project_work_order
  belongs_to :item

  def item_name=(name)
    self.item_id = Item.find_by_name(name).id
  end

  def item_name
    item.try(:name)
  end
end
