class ItemReceive < ActiveRecord::Base
  attr_accessible :purchase_order_id, :number, :user_date, :remark
end
