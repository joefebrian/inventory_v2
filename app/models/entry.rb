class Entry < ActiveRecord::Base
  belongs_to :item
  belongs_to :plu
  belongs_to :company
  belongs_to :transaction, :foreign_key => :transaction_id
  validates_presence_of :quantity
  attr_writer :plu_code, :validating_quantity, :warehouse_id
  before_save :assign_item_id
  before_save :assign_company_id

  named_scope :for_transactions, lambda { |ids|
    { :conditions => { :transaction_id => ids } }
  }

  def validate
    if @validating_quantity  && !quantity.blank?
      stock = Entry.quantity_in_warehouse(@warehouse_id, plu_id)
      errors.add(:quantity, "of #{plu.item.name} exceeded actual stock (#{stock})") if (!quantity.blank? && quantity > stock)
    end
  end

  def validating_quantity?
    @validating_quantity
  end

  def self.quantity_in_warehouse(warehouse, plu)
    item = Plu.find(plu).item
    Warehouse.find(warehouse).item_quantity(item)
  end

  def total_value
    value * quantity
  end

  def plu_code
    @plu_code || plu.try(:code)
  end

  def assign_item_id
    self.item_id = Plu.find(self.plu_id).item_id unless self.plu_id.blank?
  end

  def assign_company_id
    self.company_id = transaction.company_id
  end

  def track
    if item.fifo? && transaction.outward?
      initial_qty = quantity
      while true
        tracker = item.tracker
        if tracker.nil?
          closed_trans = item.closed_trackers.map(&:reference_transaction_id)
          ref = company.transactions.inward.altering_stock.contain(item).not_in(closed_trans).first
          ref_entry = ref.entries.first(:conditions => { :item_id => item })
          initial_qty = company.fifo_trackers.new.log(self, initial_qty,  ref_entry)
        else
          initial_qty = tracker.log(self, initial_qty)
        end
        if initial_qty <= 0
          break
        end
      end
    end
  end

  def calculated_value
    if transaction.outward?
      tmp_value = 0
      if item.fifo?
        trackers = FifoTracker.all(:conditions => { :consumer_transaction_id => transaction.id })
        trackers.each do |tracker|
          tmp_value = tmp_value + (tracker.value * tracker.quantity_consumed)
        end
        tmp_value
      end
    else
      value * quantity
    end
  end
end
