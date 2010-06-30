class Customer < ActiveRecord::Base
  attr_accessible :profile_id, :code, :profile_attributes, :tax_profile_attributes, :item_code, :special_prices_attributes
  belongs_to :company
  belongs_to :profile
  has_one :tax_profile
  has_many :special_prices, :class_name => "CustomerPrice", :order => "units.position", :include => :unit

  validates_presence_of :code
  validates_uniqueness_of :code, :scope => :company_id
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :tax_profile
  accepts_nested_attributes_for :special_prices, :allow_destroy => true, :reject_if => lambda { |at| at[:price].blank? }

  def special_prices_matrix
    matrix = {}
    for price in special_prices
      matrix[price.item.code] = {} if matrix[price.item.code].blank?
      matrix[price.item.code]['item'] = price.item if matrix[price.item.code]['item'].blank?
      matrix[price.item.code]['prices'] = [] if matrix[price.item.code]['prices'].blank?
      matrix[price.item.code]['prices'] << price
    end
    matrix
  end

  def item_code
    @item_code
  end
end
