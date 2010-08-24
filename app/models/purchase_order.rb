class PurchaseOrder < ActiveRecord::Base
  belongs_to :company
  belongs_to :supplier
  has_many :entries, :class_name => "PurchaseOrderEntry", :dependent => :destroy
  has_and_belongs_to_many :material_requests
  attr_writer :current_step

  validates_presence_of :number, :if => lambda {|o| o.current_step == 'po' }
  validates_uniqueness_of :number, :scope => :company_id, :if => lambda {|o| o.current_step == 'po' }
  validates_presence_of :supplier_id, :if => lambda {|o| o.current_step == 'po' }
  validates_presence_of :po_date, :if => lambda {|o| o.current_step == 'po' }

  after_save :close_material_requests

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att[:quantity].blank? || att[:quantity].to_i.zero? || att[:purchase_price].blank? || att[:purchase_price].to_i.zero? }

  def current_step
    @current_step || steps.first
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def last_step?
    current_step == steps.last
  end

  def steps
    %w[po items]
  end
  
  def after_initialize
    self.number = suggested_number if new_record?
    self.po_date = Time.now.to_date.to_s(:long) if self.po_date.blank?
  end

  def suggested_number
    last_number = company.purchase_orders.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:purchase_orders]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
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
end
