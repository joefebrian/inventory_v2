class PurchaseOrder < ActiveRecord::Base
  belongs_to :company
  belongs_to :supplier
  belongs_to :material_request
end
