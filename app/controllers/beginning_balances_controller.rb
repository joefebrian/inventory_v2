class BeginningBalancesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  def index
    @search = current_company.beginning_balances.search(params[:search])
    @beginning_balances = @search.paginate(:page => params[:page])
  end

  def show
    @beginning_balance = BeginningBalance.find(params[:id])
  end
  
  def new
    @categories = current_company.leaf_categories
    @beginning_balance = current_company.begining_balances.new
    @beginning_balance.number = BeginningBalance.suggested_number(current_company)
  end
  
  def create
    @beginning_balance = current_company.beginning_balances.new(params[:beginning_balance])
    @beginning_balance.destination_warehouse = current_company.default_warehouse
    if params[:get_mrs] && params[:get_mrs].to_i == 1
      @categories = current_company.leaf_categories
      @beginning_balance.build_entries_from_categories(params[:categories])
      @beginning_balance.entries.build
      render("new", :layout => false) and return
    end
    if @beginning_balance.save
      flash[:notice] = "Successfully created begining balance."
      redirect_to beginning_balances_url
    else
      @categories = current_company.leaf_categories
      render :action => 'new'
    end
  end
  
  def edit
    @categories = current_company.leaf_categories
    @beginning_balance = BeginningBalance.find(params[:id])
  end
  
  def update
    @beginning_balance = BeginningBalance.find(params[:id])
    if @beginning_balance.update_attributes(params[:beginning_balance])
      flash[:notice] = "Successfully updated beginning balance."
      redirect_to beginning_balances_url
    else
      @categories = current_company.leaf_categories
      render :action => 'edit'
    end
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'bb'
  end
end
