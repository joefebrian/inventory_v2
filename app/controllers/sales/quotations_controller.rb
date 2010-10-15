class Sales::QuotationsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  
  def index
    @search = current_company.quotations.search(params[:search])
    @quotations = @search.paginate(:page => params[:page])
  end
  
  def show
    @quotation = current_company.quotations.find(params[:id])
  end
  
  def new
    @quotation = current_company.quotations.new
    @quotation.entries.build
    @customer = current_company.customers.all(:include => :profile)
  end
  
  def create
    @quotation = current_company.quotations.new
    @quotation.attributes = params[:quotation]
    if @quotation.save
      flash[:notice] = "Successfully created quotation."
      redirect_to sales_quotation_path(@quotation)
    else
      @quotation.entries.build
      @customer = current_company.customers.all(:include => :profile)
      render :action => 'new'
    end
  end
  
  def edit
    @quotation = current_company.quotations.find(params[:id])
    @quotation.entries.build
    @customer = current_company.customers.all(:include => :profile)
  end
  
  def update
    @quotation = current_company.quotations.find(params[:id])
    if @quotation.update_attributes(params[:quotation])
      flash[:notice] = "Successfully updated quotation."
      redirect_to sales_quotation_path(@quotation)
    else
      @quotation.entries.build
      @customer = current_company.customers.all(:include => :profile)
      render :action => 'edit'
    end
  end
  
  def destroy
    @quotation = current_company.quotations.find(params[:id])
    @quotation.destroy
    flash[:notice] = "Successfully destroyed quotation."
    redirect_to sales_quotations_path
  end  
  
  def send_request
=begin
    @quotation = current_company.quotations.find(params[:id])
    for customer in @quotation.costumer
      PurchasingMailer.deliver_quotation(@quotation, customer)
    end
    flash[:notice] = "Quotation request sent"
    redirect_to [:purchasing, @quotation_request]
=end
      redirect_to sales_quotation_path(@quotation)
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'quo'
  end
  
end
