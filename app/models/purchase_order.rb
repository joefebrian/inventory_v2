class PurchaseOrder < ActiveRecord::Base
  belongs_to :company
  belongs_to :supplier
  belongs_to :material_request

  validates_presence_of :number
  validates_uniqueness_of :number, :scope => :company_id
  validates_presence_of :supplier_id
  validates_presence_of :po_date

  def after_initialize
    self.number = suggested_number if new_record?
    self.po_date = Time.now.to_date.to_s(:long) if new_record?
  end

  def suggested_number
    last_number = company.purchase_orders.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:material_request]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end
end
