class TransAssembliesEntry < ActiveRecord::Base
  belongs_to :trans_assembly
  belongs_to :item

  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end

end
