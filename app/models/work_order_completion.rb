class WorkOrderCompletion < ActiveRecord::Base
  belongs_to :work_order
  belongs_to :assembly

  before_save :restrict_quantity

  def completed
    @completed || work_order.completions.all(:conditions => { :assembly_id => assembly_id }).map(&:quantity).sum
  end

  def total_quantity
    @total_quantity || work_order.entries.reject {|e| e.assembly_id.to_i != assembly_id }.first.quantity
  end

  def remaining
    total_quantity - completed
  end

  def restrict_quantity
    self.quantity = remaining if quantity > remaining
  end
end
