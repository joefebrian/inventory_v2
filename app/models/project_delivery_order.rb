class ProjectDeliveryOrder < ActiveRecord::Base
  belongs_to :project
  belongs_to :material_request
  has_many :entries, :class_name => "ProjectDeliveryOrderEntry"

  accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => lambda { |att| att['item_name'].nil? && att['amount'].nil? }
end
