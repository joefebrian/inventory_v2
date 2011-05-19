class ProjectDeliveryOrderEntry < ActiveRecord::Base
  belongs_to :project_delivery_order
  belongs_to :item

  def item_name=(name)
    i = project_delivery_order.project.company.items.find_by_name(name)
    self.item_id = i.id if i
  end

  def item_name
    item.try(:name)
  end
end
