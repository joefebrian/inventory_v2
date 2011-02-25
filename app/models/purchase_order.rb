class PurchaseOrder < ActiveRecord::Base
  belongs_to :company
  belongs_to :supplier
  has_many :entries, :class_name => "PurchaseOrderEntry", :dependent => :destroy
  has_many :item_receives, :class_name => "ItemReceive"
  has_and_belongs_to_many :material_requests

  validates_presence_of :number
  validates_uniqueness_of :number, :scope => :company_id
  validates_presence_of :supplier_id
  validates_presence_of :po_date

  after_save :close_material_requests
  after_validation :populate_total

  named_scope :all_closed, :conditions => { :closed => true }
  named_scope :all_open, :conditions => { :closed => false }

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att[:quantity].blank? || att[:quantity].to_i.zero? || att[:purchase_price].blank? || att[:purchase_price].to_i.zero? }

  def after_initialize
    self.number = suggested_number if new_record?
    self.po_date = Time.now.strftime("%m/%d/%Y") if new_record?
  end

  def suggested_number
    last_number = company.purchase_orders.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:purchase_orders]}.#{Time.now.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end

  def build_entries_from_mr
    entries.clear
    mr_entries = MaterialRequestEntry.all(:conditions => { :material_request_id => material_request_ids },
                                     :group => :item_id)
    mr_entries.each do |entry|
      item = entry.item
      quantity = item.total_quantity_in_mr(material_request_ids)
      if quantity > 0
        self.entries.build(:item_id => item.id,
                           :quantity => quantity,
                           :purchase_price => item.base_price)
      end
    end
  end

  def build_mr_trackers
    entries.each do |entry|
      mr = MaterialRequest.id_in(material_request_ids).entries_item_id_is(entry.item_id)
      mr.each do |m|
        mr_entry_qty_left = m.quantity_left_for(entry.item_id)
        if mr_entry_qty_left > 0
          entry.trackers.build(:purchase_order_entry_id => entry.id,
                              :material_request_id => m.id,
                              :quantity => mr_entry_qty_left,
                              :item_id => entry.item_id)
        end
      end
    end
  end

  def material_request_numbers
    material_requests.collect {|mr| mr.number}.join(', ')
  end

  def close_material_requests
    material_requests.each { |mr| mr.close }
  end

  def name
    number
  end

  def items
    company.items.all(:conditions => { :id => entries.collect { |e| e.item_id }}, :group => :id )
  end

  def quantity_left(item)
    total = entries.find_by_item_id(item).quantity
    used = ItemReceiveEntry.item_receive_purchase_order_id_is(id).item_id_is(item).sum(:quantity)
    total - used
  end

  def close
    quantity_left = items.collect { |item| quantity_left(item) }.sum
    self.closed = quantity_left.zero? ? true : false
    save
  end

  def entries_plu_satisfied?
    entries.each do |entry|
      # false if the quantity left for this entry's item is
      return false unless entry.item.plu_for(supplier).present?
    end
    true
  end

  def total_value
    entries.sum :total
  end

  def populate_total
    self.total = with_tax ? (tax_value + total_value) : total_value
    true
  end

  def tax_value
    with_tax? ? (total_value * PPN) / 100 : 0
  end

end

