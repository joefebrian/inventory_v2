class CustomerDownPaymentsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  
  def index
    @search = current_company.customer_down_payments.search(params[:search])
    @customer_down_payments = @search.paginate(:page => params[:page])
  end
  
  def show
    @customer_down_payment = current_company.customer_down_payments.find(params[:id])
  end

  def new
    @customer_down_payment = current_company.customer_down_payments.new
    @customer = current_company.customers
  end 
  
  def create
    @customer_down_payment = current_company.customer_down_payments.new(params[:customer_down_payment])
    if @customer_down_payment.save
      flash[:notice] = "Successfully created Customer Down Payment."
      redirect_to customer_down_payment_path(@customer_down_payment)
    else
      render :action => 'new'
    end
  end

  def edit
    @customer_down_payment = current_company.customer_down_payments.find(params[:id])
  end
  
  def update
    @customer_down_payment = current_company.customer_down_payments.find(params[:id])
    if @customer_down_payment.update_attributes(params[:customer_down_payment])
      flash[:notice] = "Successfully updated Customer Down Payment."
      redirect_to customer_down_payment_path(@customer_down_payment)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @customer_down_payment = current_company.customer_down_payments.find(params[:id])
    @customer_down_payment.destroy
    flash[:notice] = "Successfully destroyed Customer Down Payment."
    redirect_to customer_down_payment_url
  end 


=begin
  def index
    @customer_down_payments = CustomerDownPayment.all
  end
  
  def show
    @customer_down_payment = CustomerDownPayment.find(params[:id])
  end
  
  def new
    @customer_down_payment = CustomerDownPayment.new
  end
 
  def create
    @customer_down_payment = CustomerDownPayment.new(params[:customer_down_payment])
    if @customer_down_payment.save
      flash[:notice] = "Successfully created customer down payment."
      redirect_to @customer_down_payment
    else
      render :action => 'new'
    end
  end
  
  def edit
    @customer_down_payment = CustomerDownPayment.find(params[:id])
  end
  
  def update
    @customer_down_payment = CustomerDownPayment.find(params[:id])
    if @customer_down_payment.update_attributes(params[:customer_down_payment])
      flash[:notice] = "Successfully updated customer down payment."
      redirect_to @customer_down_payment
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @customer_down_payment = CustomerDownPayment.find(params[:id])
    @customer_down_payment.destroy
    flash[:notice] = "Successfully destroyed customer down payment."
    redirect_to customer_down_payments_url
  end
=end
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'cdp'
  end

end
