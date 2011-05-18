class ProjectDeliveryOrder < ActiveRecord::Base
  belongs_to :project
  belongs_to :material_request
end
