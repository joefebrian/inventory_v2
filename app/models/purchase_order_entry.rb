class PurchaseOrderEntry < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :item
  has_many :trackers, :class_name => "PoMrTracker", :dependent => :destroy

  accepts_nested_attributes_for :trackers,
    :allow_destroy => true
  
  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end

  def after_initialize
    if new_record?
      self.discount = 0
    end
  end
end
