class AssemblyEntry < ActiveRecord::Base
  belongs_to :assembly
  belongs_to :item
  
  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end
end
