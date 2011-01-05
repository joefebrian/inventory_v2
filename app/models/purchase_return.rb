class PurchaseReturn < ActiveRecord::Base
  attr_accessible :company_id, :number, :supplier_id, :purchase_order_id, :remark, :user_date, :entries_attributes
  belongs_to :company
  belongs_to :supplier
  belongs_to :purchase_order
  
  has_many :entries, :class_name => "PurchaseReturnEntry"

  validates_presence_of :supplier_id
  validates_presence_of :number
  validates_presence_of :user_date
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att['plu_id'].blank? || att['quantity'].blank? || att['quantity'].to_i <= 0 }

  def after_initialize
    self.number = suggested_number if new_record?
    self.user_date = Time.now.strftime("%d/%m/%Y") if self.user_date.blank?
  end

  def suggested_number
    last_number = company.purchase_returns.last.try(:number)
    last_number = "#{TRANS_PREFIX[:purchase_returns]}.#{time.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end

end
