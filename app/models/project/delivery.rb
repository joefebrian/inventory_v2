class Project
  class Delivery < ActiveRecord::Base
    belongs_to :spk, :class_name => "Project::Spk"
    has_and_belongs_to_many :spk_requests, :class_name => "Project::MaterialRequest"
    has_many :entries, :class_name => "Project::Material::DeliveryEntry"

    accepts_nested_attributes_for :entries, :allow_destroy => false, :reject_if => lambda { |a| a['quantity'].blank? || a['quantity'].to_i <= 0 }

    def build_entries
      tmp = {}
      spk_requests.each do |req|
        req.entries.each do |r|
          tmp[r.item_id] = 0 if tmp[r.item_id].nil?
          tmp[r.item_id] += r.quantity
        end
      end
      entries.clear
      tmp.each {|i, q| entries.build(:item_id => i, :quantity => q) }
    end
  end
end
