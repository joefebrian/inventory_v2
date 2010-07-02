class PriceListEntry < ActiveRecord::Base
  belongs_to :price_list
  belongs_to :item
  belongs_to :unit

  validates_presence_of :value
end
