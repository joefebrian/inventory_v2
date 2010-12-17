class AssemblyProgressEntry < ActiveRecord::Base
  belongs_to :assembly, :class_name => "TransAssembly", :foreign_key => "trans_assembly_id"
  belongs_to :assembly_entry, :class_name => "TransAssembliesEntry", :foreign_key => "assembly_entry_id"

end
