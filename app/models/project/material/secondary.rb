class Project
  module Material
    class Secondary < Base
      belongs_to :spk, :class_name => "Project::Spk"

      validates_presence_of :price
      validates_numericality_of :price
    end
  end
end
