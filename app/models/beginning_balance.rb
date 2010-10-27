class BeginningBalance < Transaction
  belongs_to :company
  belongs_to :destination_warehouse, :class_name => "Warehouse", :foreign_key => :destination_id
  has_many :entries, :foreign_key => :transaction_id, :dependent => :destroy
  has_and_belongs_to_many :categories
  validates_presence_of :number
  before_save :assign_alter_stock

  def category_name
    @category_name || entries.first.try(:item).try(:category).try(:name)
  end

  def build_entries_from_categories
    categories.each do |cat|
      cat.items.each do |item|
        self.entries.build(:item_id => item.id)
      end
    end
  end

  def self.suggested_number(company)
    last_number = super(company, self.to_s)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:beginning_balance]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  private
  def assign_alter_stock
    self.alter_stock = true
  end
end
