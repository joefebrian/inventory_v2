class CustomerPrice < ActiveRecord::Base
  attr_accessible :customer_id, :item_id, :unit_id, :item_code
  attr_writer :current_step, :item_code

  belongs_to :customer
  belongs_to :item
  belongs_to :unit

  def item_code
    @item_code || item.try(:code)
  end

  def steps
    %w[item_select unit_fill_in confirmation]
  end

  def current_step
    @current_step || steps.first
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1] unless last_step?
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1] unless first_step?
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
