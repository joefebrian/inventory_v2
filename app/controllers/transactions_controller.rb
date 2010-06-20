class TransactionsController < ApplicationController
  def created
    from = Chronic.parse(params[:from].blank? ? '01/01/1970' : params[:from]).to_s(:db)
    to = Chronic.parse(params[:until].blank? ? 'now' : params[:until]).to_s(:db)
    cat = params[:category]
    unless cat.blank?
      cat = Category.find(cat)
      cat = cat.leaf? ? [cat.id] : cat.leaf_ids
    else
      cat = []
    end
    if params[:warehouse].blank?
      wh = GeneralTransaction.all.collect { |t| t.transaction_type_id }
    else
      wh = GeneralTransaction.origin_id_or_destination_id_in(params[:warehouse]).collect { |t| t.transaction_type_id }
    end
    all = TransactionType.all.collect { |ty| ty.id }
    in_categories = GeneralTransaction.entries_item_category_id_in(cat).collect { |t| t.transaction_type_id }
    occured = GeneralTransaction.created_at_gte(from).created_at_lte(to).collect { |t| t.transaction_type_id }
    @hidden_types = all - (in_categories & wh & occured)
  end
end
