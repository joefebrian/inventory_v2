class Assembly < ActiveRecord::Base
  attr_accessible :item_id, :company_id, :number, :type, :description, :qty, :detail_assemblies_attributes
  has_many :detail_assemblies
  belongs_to :items
  belongs_to :company
  validates_presence_of :number
  validates_presence_of :type
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :detail_assemblies, :allow_destroy => true, :reject_if => lambda {|a| a['qty'].blank? }
 # attr_accessor :item_name, :supplier_name

 def self.suggested_number(company)
    last_number = Assembly.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:assembly]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def item_name
    @item_name || item.try(:name_with_code)
  end
  
  def item_name_with_code
    item.name_with_code
  end

end
