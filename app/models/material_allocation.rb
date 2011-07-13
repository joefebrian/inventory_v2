class MaterialAllocation < ActiveRecord::Base
  belongs_to :company
  belongs_to :allocatable, :polymorphic => true
  belongs_to :item

  def transaction_reference
    case self.allocatable_type
    when 'Project::MaterialRequest'
      "Project Material Request #{allocatable.number}"
    else
      'undefined'
    end
  end
end
