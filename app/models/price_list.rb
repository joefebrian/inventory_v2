class PriceList < ActiveRecord::Base
  belongs_to :company
  has_many :entries, :class_name => 'PriceListEntry', :dependent => :destroy

  validates_presence_of :code
  validates_presence_of :name
  validates_uniqueness_of :code, :scope => :company_id
  validates_uniqueness_of :name, :scope => :company_id

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |at| at['value'].blank? }

  named_scope :active, :conditions => [ "active_from <= ? AND active_until >= ?", Time.now.to_date, Time.now.to_date]

  def currently_active?
    now = Time.now.to_date
    now >= active_from && now <= active_until
  end

  def active?
    currently_active?
  end
end
