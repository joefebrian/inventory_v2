class ItemMovementReport < Reporter
  def initialize(company)
    super(company)
  end

  def generate
    determine_transaction_boundaries
    start_balances, end_balances = item_balances
    entries_grouping
    @matrix
  end

  def entries_grouping
    entries = @transactions.map(&:entries).flatten
    if @warehouse
    else
      @items.each do |item|
        @matrix[item.id] = @all_transactions.collect {|t| [t.id, 0] unless t.transfer?}
      end
    end
  end

  def determine_transactions_in_time_range!
    @transactions = @company.general_transactions.created_at_gte(@time_start).created_at_lte(@time_end)
  end

  def determine_transaction_category!
    if @category
      @category.leaf? ? @transactions.entries_item_category_is(@category) : @transactions.entries_item_category_in(@category.leaf_ids)
    end
  end

  def determine_transaction_warehouses!
    @transactions.origin_id_or_destination_id_is(@warehouse) if @warehouse
  end

  def determine_transaction_boundaries
    determine_transactions_in_time_range!
    determine_transaction_category!
    determine_transaction_warehouses!
  end
end
