class PurchaseReturnEntry < ActiveRecord::Base
  belongs_to :purchase_entry
  belongs_to :plu

  def item
    plu.try(:item)
  end

  def plu_code
    plu.try(:code)
  end

  def plu_code=(code)
  end
end
