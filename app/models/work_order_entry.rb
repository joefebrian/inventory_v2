class WorkOrderEntry < ActiveRecord::Base
  belongs_to :assembly
  belongs_to :work_order

  def assembly_name
    assembly.try(:name)
  end
  
  def assembly_name=(name)
  end

  def item_name
    assembly.try(:item).try(:name)
  end

  def completed
    progress_entries.sum(:quantity)
  end
end
