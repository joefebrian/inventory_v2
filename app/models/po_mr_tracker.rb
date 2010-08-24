class PoMrTracker < ActiveRecord::Base
  belongs_to :purchase_order_entry
  belongs_to :material_request
end
