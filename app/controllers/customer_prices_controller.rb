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
    session[:customer_price_params] ||= {}
    @customer = Customer.find(params[:customer_id])
    @customer_price = @customer.special_prices.new(session[:customer_price_params])
    @customer_price.current_step = session[:customer_price_step]
  end
  
  def create
    session[:customer_price_params].deep_merge!(params[:customer_price]) if params[:customer_price]
    @customer = Customer.find(params[:customer_id])
    @customer_price = @customer.special_prices.new(session[:customer_price_params])
    @customer_price.current_step = session[:customer_price_step]
    if @customer_price.valid?
      if params[:back_button]
        @customer_price.previous_step
      elsif @customer_price.last_step?
        #@customer_price.save if @customer_price.all_valid?
      else
        @customer_price.next_step
        if @customer_price.current_step == 'unit_fill_in'
          @item = Item.find(params[:customer_price][:item_id])
        end
      end
      session[:customer_price_step] = @customer_price.current_step
    end
    if @customer_price.new_record?
      render "new"
    else
      session[:customer_price_step] = session[:customer_price_params] = nil
      flash[:notice] = "Order saved!"
      redirect_to @customer_price
    end
  end
  
  def edit
    @customer_price = CustomerPrice.find(params[:id])
  end
  
  def update
    @customer_price = CustomerPrice.find(params[:id])
    if @customer_price.update_attributes(params[:customer_price])
      flash[:notice] = "Successfully updated customer price."
      redirect_to @customer_price
    else
      render :action => 'edit'
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
