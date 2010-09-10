class ItemReceiveEntry < ActiveRecord::Base
  belongs_to :item_receive
  belongs_to :item

  def item_name
    item.try(:name)
  end

  def item_name=(name)
  end
end
