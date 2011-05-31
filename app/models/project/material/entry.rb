class Project
  module Material
    class Entry < Base
      belongs_to :material_request, :class_name => "Project::MaterialRequest"
      belongs_to :item

      validates_presence_of :quantity
      validates_numericality_of :quantity

      def validate
        errors.add(:quantity, "must be greater than zero") if quantity.to_i <= 0
      end

      def item_name=(name)
      end

      def item_name
        item.try(:name)
      end
    end
  end
end
