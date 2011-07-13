class Project
  class MaterialRequest < ActiveRecord::Base
    attr_accessor :auto_allocation
    after_create :generate_record_number
    after_create :check_and_generate_allocation, :if => Proc.new { |req| req.need_allocation? }
    has_many :entries, :class_name => "Project::Material::Entry"
    has_many :material_allocations, :as => :allocatable
    belongs_to :spk, :class_name => "Project::Spk"
    has_and_belongs_to_many :deliveries, :class_name => "Project::Delivery"

    accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => lambda { |a| a['quantity'].blank? || a['quantity'].to_i <= 0 }
    validates_presence_of :requester, :due_date

    def generate_record_number
      self.number = "SPK-MR.#{'%.6d' % id}"
      save(false)
    end

    def check_and_generate_allocation
      generate_allocation if require_allocation?
    end

    def require_allocation?
      !entries.detect { |e| e.item.stock < e.quantity }.nil?
    end

    def generate_allocation
      entries.each do |e|
        if e.item.stock < e.quantity
          malloc = material_allocations.new
          malloc.item_id = e.item_id
          malloc.quantity = e.quantity
          malloc.company_id = spk.company_id
          malloc.save
        end
      end
    end

    #private
    def need_allocation?
      auto_allocation.to_i == 1 && require_allocation?
    end
  end
end
