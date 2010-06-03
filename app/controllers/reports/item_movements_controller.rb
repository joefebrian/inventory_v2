class Reports::ItemMovementsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @categories = current_company.categories.sorted
    @transactions = current_company.transaction_types
    @warehouses = current_company.warehouses

    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def generate
    @params = params[:report]
    balance_end_date = @params[:from].blank? ? Time.now.beginning_of_month : @params[:from].kind_of?(Time) ? @params[:from] : Chronic.parse(@params[:from])
    all_items = Item.search(:company_id => current_company)
    cat = Category.find(@params[:category]) unless @params[:category].blank?
    if cat
      if cat.leaf?
        all_items = all_items.category_id_is(@params[:category])
      else
        all_items = all_items.category_id_in(cat.leaf_ids)
      end
    end
    @items = all_items.all(:order => 'name ASC').paginate(:page => params[:page])
    @ins, @outs, trf, other_in, other_out, other_trf = [], [], [], [], [], []
    @params[:transactions].each do |t|
      tt = TransactionType.find(t)
      if tt.inward? 
        if @ins.length <= 3
          @ins << tt
        else
          other_in << tt
        end
      elsif tt.outward?
        if @outs.length <= 3
          @outs << tt
        else
          other_out << tt
        end
      else
        if trf.length <= 3
          trf << tt
        else
          other_trf << tt
        end
      end
    end
    @rows = []
    @items.each do |i|
      row = {}
      row[:item] = i
      row[:start_balance] = i.sum_on_hand_between(nil, balance_end_date - 1.day )
      row[:end_balance] = i.stock
      row[:other_in] = i.total_quantity_for_transactions(other_in, @params[:from], @params[:until])
      unless @params[:from].blank? && @params[:until].blank?
        row[:other_in] = row[:other_in] + i.total_begining_balance_between(@params[:from], @params[:until])
      end
      row[:other_out] = i.total_quantity_for_transactions(other_out, @params[:from], @params[:until])
      row[:user_in] = @ins.collect { |tt| i.total_quantity_for_transaction(tt, @params[:from], @params[:until]) }
      row[:user_out] = @outs.collect { |tt| i.total_quantity_for_transaction(tt, @params[:from], @params[:until]) }
      @rows << row
    end
    respond_to do |format|
      format.html { render :layout => 'wide' }
      format.pdf
    end
  end

  private
  def assign_tab
    @tab = 'reports'
    @current = 'im'
  end
end
