class PurchaseOrderEntry < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :item
  has_many :trackers, :class_name => "PoMrTracker", :dependent => :destroy

  accepts_nested_attributes_for :trackers,
    :allow_destroy => true
  
  #before_save :populate_total

  def item_name
    item.try(:name)
  end
  
  def item_name=(name)
  end

  def after_initialize
    if new_record? && (discount.blank? || discount.to_i <= 0)
      self.discount = 0
    end
  end

  def populate_total
    before_discount = (quantity * purchase_price)
    discount_value = (before_discount * discount) / 100
    self.total = before_discount - discount_value
  end
end
