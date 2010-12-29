class Role < ActiveRecord::Base
  attr_accessible :name, :company_id, :privilege_resources
  belongs_to :company
  has_and_belongs_to_many :users
  has_many :privileges

  validates_presence_of :name

  def has_privilege?(resource)
    privileges.collect { |priv| priv.resource }.include? resource
  end

  def privilege_resources=(resources)
    resources.each do |res|
      privileges << Privilege.new(:company => company, :resource => res)
    end
  end

  def sorted_privileges
    priv = {}
    resources = privileges.collect { |p| p.resource }
    PRIVILEGES.each do |key, val|
      priv[key] = val.select { |k,v| resources.include? v }
    end
    priv
  end
end
