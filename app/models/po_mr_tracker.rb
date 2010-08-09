class PoMrTracker < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :material_request
end
