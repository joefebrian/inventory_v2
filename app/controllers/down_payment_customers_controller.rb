class DownPaymentCustomersController < ApplicationController
  def index
    @down_payment_customers = DownPaymentCustomer.all
  end
  
  def show
    @down_payment_customer = DownPaymentCustomer.find(params[:id])
  end
  
  def new
    @down_payment_customer = DownPaymentCustomer.new
  end
  
  def create
    @down_payment_customer = DownPaymentCustomer.new(params[:down_payment_customer])
    if @down_payment_customer.save
      flash[:notice] = "Successfully created down payment customer."
      redirect_to @down_payment_customer
    else
      render :action => 'new'
    end
  end
  
  def edit
    @down_payment_customer = DownPaymentCustomer.find(params[:id])
  end
  
  def update
    @down_payment_customer = DownPaymentCustomer.find(params[:id])
    if @down_payment_customer.update_attributes(params[:down_payment_customer])
      flash[:notice] = "Successfully updated down payment customer."
      redirect_to @down_payment_customer
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @down_payment_customer = DownPaymentCustomer.find(params[:id])
    @down_payment_customer.destroy
    flash[:notice] = "Successfully destroyed down payment customer."
    redirect_to down_payment_customers_url
  end
end
