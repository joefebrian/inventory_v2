class ProjectWorkOrder < ActiveRecord::Base
  attr_accessible :project_id, :number, :user_date, :valid_since, :valid_thru, :payment_term

  belongs_to :project
  validates_presence_of :number, :user_date, :valid_since, :valid_thru, :payment_term
  validates_uniqueness_of :number, :scope => :project_id

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = ProjectWorkOrder.project_company_id_is(company_id).all(:order => "number ASC").last.try(:number)
    last_number = "#{TRANS_PREFIX[:spk]}.#{Time.now.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end
end
