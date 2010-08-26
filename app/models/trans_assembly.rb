class TransAssembly < ActiveRecord::Base
  attr_accessible :company_id, :warehouse_id, :assembly_id, :number, :quantity, :date, :description, :entries_attributes
  belongs_to :company
  belongs_to :warehouse
  belongs_to :assembly
  has_many :entries, :class_name => "TransAssembliesEntry"
  validates_presence_of :number, :quantity, :warehouse_id, :assembly_id
  validates_uniqueness_of :number, :scope => :company_id
  
  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda {|at| at['quantity'].blank? || at['quantity'].to_i == 0}

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.trans_assemblies.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:trans_assemblies]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def tgl_active
   date = Chronic.parse(date)
  end

  def build_entries_from_one
    entries.clear
    unless assembly.blank?
      items = AssemblyEntry.calculate(:sum,
                                             :quantity,
                                             :conditions => { :assembly_id => assembly_id },
                                             :group => :item_id)
      items.each do |item_id, qty|
        self.entries.build(:item_id => item_id,
                           :quantity => qty)
      end
    end
  end

end
