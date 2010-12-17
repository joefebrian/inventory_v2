class TransAssembly < ActiveRecord::Base
  attr_accessible :company_id, :warehouse_id, :number, :date, :description, :entries_attributes
  belongs_to :company
  belongs_to :warehouse
  has_many :entries, :class_name => "TransAssembliesEntry"
  has_many :progress_entries, :class_name => "AssemblyProgressEntry"
  validates_presence_of :number, :warehouse_id
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

  def build_entries_from_assembly
    entries.clear
    unless assembly.blank?
      assy_entries = AssemblyEntry.all(:conditions => { :assembly_id => assembly_id }, :group => :item_id)
      assy_entries.each do |entry|
        self.entries.build(:item_id => entry.item_id, :quantity => (entry.quantity * quantity.to_i == 0 ? 1 : quantity))
      end
    end
  end

end
