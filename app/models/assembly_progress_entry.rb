class AssemblyProgressEntry < ActiveRecord::Base
  belongs_to :trans_assembly
  belongs_to :trans_assemblies_entry
end
