class Assembly < ActiveRecord::Base
  attr_accessible :company_id, :category_id, :tipe, :number, :code, :name, :description, :entries_attributes
  belongs_to :company
  belongs_to :category
  has_many :trans_assemblies
  
  has_many :entries, :class_name => "AssemblyEntry"
  validates_presence_of :number, :tipe, :code, :name, :category_id
  validates_uniqueness_of :number, :scope => :company_id
  validates_uniqueness_of :name, :scope => :company_id

  accepts_nested_attributes_for :entries, 
    :allow_destroy => true, 
    :reject_if => lambda {|a| a['quantity'].blank? }

 def self.suggested_number(company)
    last_number = Assembly.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:assembly]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end
  
 def after_save 
   Item.create(:category_id => category_id, :company_id => company_id, :code => code, :name => name, :description => description, :is_stock => true)
 end

end
