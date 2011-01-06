class Invoice < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :item_receives, :join_table => "invoices_item_receives", :class_name => "ItemReceive"

  validates_presence_of :number
  validates_presence_of :user_date

  def validate
    errors.add(:vat, "Must be number") unless vat.blank? || (vat.to_s =~ /^(\d+)$/) == 0
    errors.add_to_base('Purchase invoice must have at least 1 item receive') if item_receives.blank?
  end

  def after_initialize
    self.number = next_available_number if new_record?
    self.user_date = Time.now.to_date
  end

  def next_available_number
    last_number = company.invoices.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:purchase_invoices]}.#{Time.now.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end

  def total_value
    item_receives.collect { |ir| ir.total }.sum
  end

  def self.grand_total(company)
    Company.find(company).invoices.collect { |inv| inv.total_value }.sum
  end

end

