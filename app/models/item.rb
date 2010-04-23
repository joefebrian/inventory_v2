class Item < ActiveRecord::Base
  attr_accessible :code, :name, :description, :category_code, :category_id, :units_attributes
  belongs_to :company
  belongs_to :category
  has_many :units
  has_many :plus
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_presence_of :category_code, :message => "category can't be blank"
  validates_presence_of :count_method
  validates_uniqueness_of :code, :scope => :company_id, :message => "code has already been taken"
  accepts_nested_attributes_for :units, :allow_destroy => true, :reject_if => lambda {|a| a['name'].blank? }

  def tracker
    company.fifo_trackers.first(:conditions => { :item_id => id, :closed => false })
  end

  def closed_trackers
    company.fifo_trackers.all(:conditions => { :item_id => id, :closed => true }, :group => :reference_transaction_id)
  end

  def category_code
    @category_code || category.try(:formatted_code)
  end

  def name_with_code
    "#{name} (#{code})"
  end

  def category_code=(catcode)
    self.category = Category.find_by_code(catcode.split.first) unless catcode.blank?
  end

  def category_tree
    "#{category.ancestors.map(&:name).join(' &gt; ')} &gt; #{category.name}"
  end

  def stock
    company.stock.item_on_hand(self)
  end

  def quantity_in_warehouse(warehouse)
    company.stock.item_on_hand_per_warehouse(warehouse, self)
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
end
