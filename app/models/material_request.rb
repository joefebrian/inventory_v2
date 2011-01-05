class MaterialRequest < ActiveRecord::Base
  attr_accessible :company_id, :number, :userdate, :reference, :requester, :description, :entries_attributes, :work_order_id
  belongs_to :company
  belongs_to :work_order
  has_many :entries, :class_name => "MaterialRequestEntry"
  has_and_belongs_to_many :purchase_orders

  validates_presence_of :number, :userdate, :reference, :requester
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att['item_id'].blank? || att['quantity'].blank? }

  named_scope :productions, :conditions => { :production => true }

  #before_save :parse_userdate

  def after_initialize
    if new_record?
      self.number = suggested_number
      self.userdate = Time.now.strftime("%m/%d/%Y") if userdate.blank?
      self.closed = false
    end
  end

  def suggested_number
    last_number = company.material_requests.last.try(:number)
    last_number = "#{TRANS_PREFIX[:material_request]}.#{time.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end

  def name
    number
  end

  def build_assembly_entries
    if work_order_id.present?
      components = []
      item_ids = AssemblyEntry.all(:conditions => {:assembly_id => work_order.entries.collect {|e| e.assembly_id}}, :group => :item_id)
      WorkOrder.find(work_order_id).entries.each do |ent|
        ent.assembly.entries.each do |comp|
          components << { :item_id => comp.item_id, :quantity => (comp.quantity * ent.quantity) }
        end
      end
      components.each do |x|
        self.entries.build(:item_id => x[:item_id], :quantity => x[:quantity])
      end
    end
  end

  def quantity_left_for(item)
    if closed
      0
    else
      entries.find_by_item_id(item).quantity - PoMrTracker.material_request_id_is(id).item_id_is(item).sum(:quantity)
    end
  end

  # mark this MR as closed if all of the entries quantity left is zero (spent on PO)
  def close
    quantity_left = entries.collect { |ent| quantity_left_for(ent.item_id) }.sum
    if quantity_left.zero?
      self.closed = true
      save
    end
  end

  def parse_userdate
    self.userdate = Chronic.parse(userdate)
  end

end
