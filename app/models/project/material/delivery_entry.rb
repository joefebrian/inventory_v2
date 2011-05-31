class Project
  module Material
    class DeliveryEntry < Base
      belongs_to :delivery, :class_name => "Project::Delivery"
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
