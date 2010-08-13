class Category < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :company
  has_many :items
  validates_presence_of :name
  has_and_belongs_to_many :begining_balances
  validates_presence_of :code
  validates_uniqueness_of :name, :scope => [:company_id, :parent_id]
  attr_writer :parent_code
  after_save :assign_parent

  def self.sorted
    roots.collect { |root| root.self_and_descendants }.flatten
  end

  def fullcode
    root? ? code : "#{parent.code} :: #{code}"
  end

  def parent_code
    @parent_code || parent.try(:fullcode)
  end

  def formatted_code
    "#{code} (#{parent.try(:code)})"
  end

  def code_for_item
    root? ? code : "#{ancestors.map(&:code).join('.')}.#{code}"
  end

  def leaf_ids
    descendants.collect {|d| d.id if d.leaf? }.compact
  end

  private
  def assign_parent
    unless @parent_code.blank?
      my_parent = company.categories.find(parent_id)
      move_to_child_of my_parent
    else
      unless root?
        move_to_root
      end
    end
  end
end
