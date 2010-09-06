class TransDiassembliesEntry < ActiveRecord::Base
  belongs_to :trans_diassembly
  belongs_to :item

  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end

end
