class Currency < ActiveRecord::Base
  attr_accessible :company_id, :code, :name, :symbol, :default
  belongs_to :company
  has_many :sales_orders
  has_many :exchane_rates
  
  validates_presence_of :name, :code, :symbol
  validates_uniqueness_of :name, :code, :symbol

  after_save :set_as_default

  def after_initialize
    self.default = false if new_record?
  end

  def set_as_default
    default_currency = company.currencies.first(:conditions => ["`default` = ? AND `id` != ?", true, id])
    default_currency.update_attributes!(:default => false) if default_currency && default?
  end
end
