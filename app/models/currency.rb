class Currency < ActiveRecord::Base
  attr_accessible :company_id, :code, :name, :symbol, :default
  belongs_to :company
  has_many :sales_orders
  has_many :exchange_rates

  validates_presence_of :name, :code, :symbol
  validates_uniqueness_of :name, :scope => :company_id
  validates_uniqueness_of :code, :scope => :company_id
  validates_uniqueness_of :symbol, :scope => :company_id

  after_save :undefault_other_currency
  after_save :create_default_exchange_rate

  def undefault_other_currency
    default_currency = company.currencies.first(:conditions => ["`default` = ? AND `id` != ?", true, id])
    default_currency.update_attributes!(:default => false) if default_currency && default?
  end

  def create_default_exchange_rate
    if default? && latest_rate.try(:value) != 1
      exchange_rates.create!(:effective_date => Time.now.to_date, :value => 1)
    end
  end

  def latest_rate
    exchange_rates.first(:order => 'effective_date DESC, created_at DESC')
  end
end
