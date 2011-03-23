class ProjectMaterial < LotItem
  belongs_to :item
  belongs_to :project

  def requested_quantity
    project.material_requests.entries_item_id_is(item_id).sum(:quantity).to_i
  end

  def unrequested_quantity
    value - requested_quantity
  end

  def processed_quantity
    project.work_orders.entries_item_id_is(item_id).sum(:quantity).to_i
  end

  def undelivered_quantity
    value - delivered_quantity
  end

  def update_delivered_quantity
    qty = project.delivery_orders.collect { |d| d.entries.all(:conditions => { :item_id => item_id }) }.flatten.sum(&:quantity)
    update_attributes(:delivered_quantity => qty)
  end

  def progress
    (delivered_quantity.to_f / value * 100).round(2)
  end
end
