class SalesOrder < ActiveRecord::Base
  attr_accessible :company_id, :quotation_id, :number, :tanggal, :top, :advance, :status, :customer_id, :retensi, :kurs_id, :kurs_value, :order_ref, :salesman_id, :entries_attributes
  has_many :entries, :class_name => "SalesOrderEntry"
  belongs_to :company
  belongs_to :assembly
  belongs_to :customer
  belongs_to :currency
  belongs_to :quotation
  belongs_to :salesman
  validates_presence_of :number, :kurs_id
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda {|at| at['quantity'].blank? || at['quantity'].to_i == 0}
  

  def tgl_active
   tanggal = Chronic.parse(tanggal_berlaku)
  end

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.sales_orders.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:sales_order]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def build_entries_from_quot
    entries.clear
    unless quotation.blank?
      items = QuotationEntry.calculate(:sum,
                                             :quantity,
                                             :conditions => { :quotation_id => quotation_id },
                                             :group => :item_id)
      items.each do |item_id, qty|
        self.entries.build(:item_id => item_id,
                           :quantity => qty)
      end
    end
  end

  def name
    number
  end

  def before_save
    unless customer_id.blank?
    end
  end
end
