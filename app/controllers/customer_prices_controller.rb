class CustomerPricesController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  def index
    @customer = Customer.find(params[:customer_id])
    @customer_prices = @customer.special_prices_matrix
  end
  
  def show
    @customer_price = CustomerPrice.find(params[:id])
  end
  
  def new
    @customer = current_company.customers.find(params[:customer_id])
    if params[:step].blank? || params[:step].to_i == 1
      @step = 1
      @item_with_special_price = @customer.special_prices.all(:group => "customer_prices.item_id").collect { |rec| rec.item_id }
      @items = current_company.items.id_not_in(@item_with_special_price).paginate(:page => params[:page])
    elsif params[:step].to_i == 2
      @step = 2
      @items = current_company.items.find(params[:item])
      for item in @items
        for unit in item.units
          @customer.special_prices.build(:item_id => item.id, :unit_id => unit.id)
        end
      end
    end
  end
  
  def create
    @customer = current_company.customers.find(params[:customer_id])
    if @customer.update_attributes(params[:customer])
      flash[:success] = "Special prices saved"
      redirect_to @customer
    else
      @step = 2
      render :action => :new
    end
  end
  
  def edit_prices
    redirect_to customer_path(params[:customer_id]) if params[:item].blank?
    @customer = current_company.customers.find(params[:customer_id])
    @special_prices = @customer.special_prices.item_id_is(params[:item]).all(:order => "customer_prices.item_id, units.position ASC")
  end
  
  def update_prices
    @customer = current_company.customers.find(params[:customer_id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Successfully updated customer price."
      redirect_to @customer
    else
      render :action => 'edit_prices'
    end
  end
  
  def destroy
    @customer_price = CustomerPrice.find(params[:id])
    @customer_price.destroy
    flash[:notice] = "Successfully destroyed customer price."
    redirect_to customer_prices_url
  end

  private
  def set_tab
    @tab = 'administrations'
    @current = 'customer'
  end
end
