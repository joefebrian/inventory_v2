class WorkOrderEntry < ActiveRecord::Base
  belongs_to :assembly
  belongs_to :work_order
  belongs_to :item

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

  def completions
    work_order.completions.all(:conditions => { :assembly_id => assembly.id }, :order => :created_at)
  end

  def complete?
    completions.map(&:quantity).sum == quantity
  end

  def required_materials
   materials = {}
   assembly.entries.each do |e|
     materials[e.item_id] = e.quantity * quantity
   end
   materials
  end
end
