class Project
  module Material
    class Request < ActiveRecord::Base
      set_table_name "project_material_requests"
      belongs_to :spk, :class_name => "Project::Spk"
    end
  end
end
