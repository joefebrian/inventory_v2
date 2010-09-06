class Purchasing::ItemReceivesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  
  def index
    @item_receives = current_company.item_receives.all.paginate(:page => params[:page])
  end
  
  def show
    @item_receive = current_company.item_receives.find(params[:id])
  end
  
  def new
    @item_receive = current_company.item_receives.new
    @purchase_orders = current_company.purchase_orders.not_closed
    @warehouses = current_company.warehouses
  end
  
  def create
    @item_receive = current_company.item_receives.new(params[:item_receive])
    @purchase_orders = current_company.purchase_orders
    @warehouses = current_company.warehouses
    if params[:get_pos] && params[:get_pos] == '1'
        @item_receive.build_entries_from_po
      render('new', :layout => false) and return
    end
    if @item_receive.save
      flash[:notice] = "Successfully created item receive."
      redirect_to purchasing_item_receife_path(@item_receive)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @item_receive = current_company.item_receives.find(params[:id])
    @purchase_orders = current_company.purchase_orders.all(:conditions => ["closed = 0 OR id = ?", @item_receive.purchase_order])
    @warehouses = current_company.warehouses
  end
  
  def update
    @item_receive = current_company.item_receives.find(params[:id])
    if @item_receive.update_attributes(params[:item_receive])
      flash[:notice] = "Successfully updated item receive."
      redirect_to purchasing_item_receife_path(@item_receive)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @item_receive = current_company.item_receives.find(params[:id])
    @item_receive.destroy
    flash[:notice] = "Successfully destroyed item receive."
    redirect_to purchasing_item_receives_url
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'ir'
  end
end
