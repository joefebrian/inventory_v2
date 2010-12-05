class SalesInvoice < ActiveRecord::Base
  attr_accessible :company_id, :delivery_order_id, :number, :ppn, :due_date, :top
  belongs_to :delivery_order
  belongs_to :sales_order
  belongs_to :company
  validates_presence_of :number
  validates_uniqueness_of :number, :scope => :company_id

  def nama
    number
  end
  
  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.sales_invoices.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:sales_invoices]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def tgl_active
   date = Chronic.parse(due_date)
  end

  def build_entries_from_do
    entries.clear
    unless delivery_order_id.blank?
     
      data_do = DeliveryOrder.all(:conditions => {:sales_order_id => sales_order_id}).collect{|d| d.id}
      item_do = DeliveryOrderEntry.calculate(:sum, 
                                           :quantity,
                                           :conditions => {:delivery_order_id => data_do},
                                           :group => :item_id)


      sales_order.entries.each do |so_data|
        item_dos = item_do.detect{|do_data1, do_data2| do_data1 == so_data.item_id.to_i}
        self.entries.build(:item_id => so_data.item_id,
                           :quantity => so_data.quantity - item_dos[1].to_i) 
 
      end
    end
  end

end
