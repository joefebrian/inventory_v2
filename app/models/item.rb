class Item < ActiveRecord::Base
  belongs_to :company
  belongs_to :category
  has_many :units
  has_many :plus
  has_many :customer_prices
  has_many :material_request_entries
  has_many :material_requests, :through => :material_request_entries
  has_many :hpps
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_presence_of :category_id, :message => "category can't be blank"
  validates_presence_of :count_method
  validates_uniqueness_of :code, :scope => :company_id, :message => "code has already been taken"
  validates_uniqueness_of :name, :scope => :company_id, :message => "name has already been taken"
  accepts_nested_attributes_for :units, :allow_destroy => true, :reject_if => lambda {|a| a['name'].blank? || a['conversion_rate'].blank? || a['conversion_rate'].to_i <= 0 || a['value'].blank? || a['value'].to_i <= 0 }

  named_scope :services, :conditions => { :is_stock => false }

  def validate
    #errors.add_to_base("All specified unit must have proper value") if units.detect { |u| (u.value.to_i <= 0 || u.conversion_rate.to_i <= 0) }
  end

  has_attached_file :photo,
    :styles => { :medium => "150x150>", :thumb => "60x60>" },
    :url => "/system/items/:id/:style/:basename.:extension",
    :path => ":rails_root/public/system/items/:id/:style/:basename.:extension"

  attr_accessor :on_hand_stock

  def available_tracker
    company.trackers.first(:conditions => { :item_id => id, :closed => false }, :order => "available_stock ASC")
  end

  def closed_trackers
    company.trackers.all(:conditions => { :item_id => id, :closed => true }, :group => :stock_entry_id)
  end

  def category_code
    @category_code || category.try(:formatted_code)
  end

  def name_with_code
    "#{name} (#{code})"
  end

  def name_with_category
    "#{name} (#{category_tree})"
  end
  def unit_type
      @unit_name || unit.try
  end
  def category_code=(catcode)
    self.category = Category.find_by_code(catcode.split.first) unless catcode.blank?
  end

  def category_tree
    "#{category.ancestors.map(&:code).join(' :: ')} :: #{category.name}"
  end

  def stock
    ins = company.entries.item_id_is(id).transaction_type_is('BeginningBalance').sum(:quantity)
    ins += company.entries.item_id_is(id).transaction_inward.transaction_altering_stock.sum(:quantity)
    out = company.entries.item_id_is(id).transaction_outward.transaction_altering_stock.sum(:quantity)
    ins - out
  end

  def stock_at(time)
    ins = company.entries.item_id_is(id).transaction_type_is('BeginningBalance').sum(:quantity)
    ins += company.entries.item_id_is(id).transaction_inward.transaction_altering_stock.updated_at_lte(time).sum(:quantity)
    out = company.entries.item_id_is(id).transaction_outward.transaction_altering_stock.updated_at_lte(time).sum(:quantity)
    ins - out
  end

  def on_hand_between(start = nil, finish = nil)
    start = start.blank? ? '01/01/1970' : start.kind_of?(Time) ? start.to_s(:db) : start
    finish = finish.blank? ? 'today' : finish.kind_of?(Time) ? finish.to_s(:db) : finish
    date_start = Chronic.parse(start).beginning_of_day
    date_end = Chronic.parse(finish).end_of_day
    ins = company.entries.item_id_is(id).transaction_inward.transaction_altering_stock.transaction_created_at_gte(date_start).transaction_created_at_lte(date_end).sum(:quantity)
    out = company.entries.item_id_is(id).transaction_outward.transaction_altering_stock.transaction_created_at_gte(date_start).transaction_created_at_lte(date_end).sum(:quantity)
    ins - out
  end

  def sum_on_hand_between(start, finish)
    @on_hand_stock = on_hand_between(start, finish)
  end

  def quantity_in_warehouse(warehouse)
    ins = company.entries.item_id_is(id).transaction_destination_id_is(warehouse).transaction_alter_stock_is(true).sum(:quantity)
    out = company.entries.item_id_is(id).transaction_origin_id_is(warehouse).transaction_alter_stock_is(true).sum(:quantity)
    ins - out
  end

  def days_range(start = nil, finish = nil)
    start = start.blank? ? '01/01/1970' : (start.kind_of?(Time) ? start.beginning_of_day : Chronic.parse(start)).beginning_of_day
    finish = finish.blank? ? Chronic.parse('today').end_of_day : (finish.kind_of?(Time) ? finish.end_of_day : Chronic.parse(finish)).end_of_day
    [start, finish]
  end

  def total_begining_balance_between(start = nil, finish = nil)
    start, finish = days_range(start, finish)
    Entry.item_id_is(self.id).transaction_type_is('BeginingBalance').transaction_created_at_gte(start).transaction_created_at_lte(finish).sum(:quantity)
  end

  def total_quantity_for_transaction(type, start = nil, finish = nil)
    start, finish = days_range(start, finish)
    Entry.item_id_is(self.id).transaction_transaction_type_id_is(type).transaction_created_at_lte(finish).transaction_created_at_gte(start).sum(:quantity)
  end

  def total_quantity_for_transactions(types, start = nil, finish = nil)
    start, finish = days_range(start, finish)
    return 0 if types.blank?
    Entry.item_id_is(self.id).transaction_transaction_type_id_in(types).transaction_created_at_lte(finish).transaction_created_at_gte(start).sum(:quantity)
  end

  def on_hand_until(time = Time.now)
    on_hand_between(nil, time)
  end

  def fifo?
    count_method == 'fifo'
  end

  def average?
    count_method == 'avg'
  end

  def lifo?
    count_method == 'lifo'
  end

  def base_price_for(position = 1)
    units.position_is(position).first.try(:value)
  end

  def base_price
    base_price_for(1)
  end

  def total_quantity_in_mr(mrs)
    total = MaterialRequestEntry.material_request_not_closed.material_request_id_in(mrs).item_id_is(id).sum(:quantity)
    spent = PoMrTracker.material_request_id_in(mrs).item_id_is(id).sum(:quantity)
    mrs.blank? ? 0 : (total - spent)
  end

  def plu_for(supplier)
    plus.all(:conditions => { :Item_id => id, :supplier_id => supplier })
  end

  def has_plu?
    plus.present?
  end

  def latest_hpp
    hpps.last.nil? ? 0 : hpps.last.value
  end

  def calculate_hpp
    eom = Time.now.last_month.end_of_month
    start_value = hpps.last.nil? ? 0 : hpps.last.value
    start_stock = stock_at(eom)
    recent_transactions = company.transactions.inward.created_at_gte(eom)
    if recent_transactions.present?
      
    end
  end
end
