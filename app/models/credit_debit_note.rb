class CreditDebitNote < ActiveRecord::Base
  attr_accessible :company_id, :number, :customer_id, :supplier_id, :user_date, :note, :credit, :value
  belongs_to :company
  belongs_to :supplier
  belongs_to :customer
  
  validates_presence_of :number, :user_date, :value
  validates_presence_of :supplier_id, :if => Proc.new { |cndn| cndn.credit == true }
  validates_presence_of :customer_id, :if => Proc.new { |cndn| cndn.credit == false }

  named_scope :credit_notes, :conditions => { :credit => true }
  named_scope :debit_notes, :conditions => { :credit => false }

  def after_initialize
    self.number = suggested_number if new_record?
    self.user_date = Time.now.strftime("%m/%d/%Y") if user_date.blank?
  end
  
  def suggested_number
    last_number = company.credit_debit_notes.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:cndn]}.#{time.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end

end
