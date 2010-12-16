class TransAssembliesEntry < ActiveRecord::Base
  belongs_to :trans_assembly
  belongs_to :assembly

  def assembly_name
    assembly.try(:name)
  end
  
  def assembly_name=(name)
  end

  def item_name
    assembly.try(:item).try(:name)
  end

end
