class MaterialRequestEntry < ActiveRecord::Base
  belongs_to :material_request
  belongs_to :item
  
  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end
end
