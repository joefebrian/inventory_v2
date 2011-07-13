class Project
  module Material
    class Main < Base
      attr_writer :item_name
      belongs_to :spk, :class_name => "Project::Spk"
      belongs_to :item

      validates_presence_of :price
      validates_presence_of :quantity
      validates_numericality_of :price
      validates_numericality_of :quantity

      def item_name
        item.name if item
      end

      def total_value
        quantity * price
      end
    end
  end
end
