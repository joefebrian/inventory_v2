class Customer < ActiveRecord::Base
  attr_accessible :profile_id, :code, :profile_attributes, :tax_profile_attributes, :item_code, :price_list_id, :special_prices_attributes, :attention, :default_top
  belongs_to :company
  belongs_to :profile
  belongs_to :price_list
  has_many :sales_orders
  has_many :delivery_orders
  has_many :quotations
  has_one :tax_profile
  has_many :special_prices, :class_name => "CustomerPrice", :order => "units.position", :include => :unit

  validates_presence_of :code
  validates_uniqueness_of :code, :scope => :company_id
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :tax_profile

  accepts_nested_attributes_for :special_prices, :allow_destroy => true, :reject_if => lambda { |at| at[:price].blank? }

  def after_initialize
    build_profile if new_record?
  end

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

  def fullname=(name)
    names = name.split(/\s/, 2)
    profile.first_name = names.first
    profile.last_name = names.last
  end

  def to_s
    profile.full_name
  end

  def fullname
    profile.full_name
  end

  def item_code
    @item_code
  end

  # get item price with this precedence, [1] special price or [2] price list or [3] purchase price
  def price_for(item, unit_position = 1)
    price = special_price_for(item, unit_position) || price_list_for(item, unit_position)
    return (price || Item.find(item).base_price_for(unit_position))
  end

  def special_price_for(item, unit_position = 1)
    special_prices.item_id_is(item).unit_position_is(unit_position).first.try(:price) # TODO consitent in attribute name (value x price)
  end

  def price_list_for(item, unit_position = 1)
    price_list.entries.item_id_is(item).unit_position_is(unit_position).first.try(:value) if price_list.try(:active?)
  end
end
