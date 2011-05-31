class Project
  module Material
    class Spk < Base
      belongs_to :spk, :class_name => "Project::Spk"
      belongs_to :item

      def item_name=(name)
        rec = spk.company.items.name_like(name).first
        if rec
          self.item_id = rec.id
        else
          self.custom_item_name = name.chomp!(' (1 lot)')
        end
      end

      def item_name
        custom_item_name ? "#{custom_item_name} (1 lot)" : item.try(:name)
      end
    end
  end
end
