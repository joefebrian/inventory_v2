class ProjectMaterial < LotItem
  belongs_to :item
  belongs_to :project

  def requested_quantity
    project.material_requests.entries_item_id_is(item_id).sum(:quantity).to_i
  end

  def unrequested_quantity
    value - requested_quantity
  end
end
