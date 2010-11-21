class SalesPrice < ActiveRecord::Base
  belongs_to :company
  belongs_to :plu
end
