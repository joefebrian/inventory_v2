class Reporter
  def initialize(company)
    @company = company.kind_of?(Company) ? company : Company.find(company)
    @items = @company.items.search
    @all_transactions = @company.transactions.type_not('BeginingBalance')
    @matrix = []
  end

  def time_start
    (@time_start || Time.now).strftime("%d/%m/%Y")
  end

  def time_start=(date = nil)
    @time_start = date
  end

  def time_end
    (@time_end || Time.now).strftime("%d/%m/%Y")
  end

  def time_end=(date = nil)
    @time_end = date
  end

  def warehouse
    @warehouse
  end

  def warehouse=(warehouse)
    @warehouse = Warehouse.find(warehouse) unless warehouse
  end

  def category
    @category
  end

  def category=(category)
    @category = Category.find(category) unless category
  end

  def displayed_transactions
    @displayed_transactions
  end

  def displayed_transactions=(ids)
    @displayed_transactions = TransactionType.id_in(ids)
  end

  def determine_time_range!
    @time_start = Time.now.beginning_of_month if @time_start.nil?
    @end_of_beginning_balance = @time_start - 1.day
    @time_end = Time.now if @time_end.nil?
  end

  def items_beginning_balance
    @items.collect { |item| { item.id => item.on_hand_until(@end_of_beginning_balance) } }
  end

  def items_end_balance
    @items.collect { |item| { item.id => item.stock } }
  end

  def item_balances
    [items_beginning_balance, items_end_balance]
  end
end
