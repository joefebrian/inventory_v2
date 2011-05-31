class Project
  class MaterialRequest < ActiveRecord::Base
    after_create :generate_record_number
    has_many :entries, :class_name => "Project::Material::Entry"
    belongs_to :spk, :class_name => "Project::Spk"
    has_and_belongs_to_many :deliveries, :class_name => "Project::Delivery"

    accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => lambda { |a| a['quantity'].blank? || a['quantity'].to_i <= 0 }

    def generate_record_number
      self.number = "SPK-MR.#{'%.6d' % id}"
      save(false)
    end
  end
end
