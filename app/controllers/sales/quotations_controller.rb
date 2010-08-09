class Sales::QuotationsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  
  def index
    @quotations = current_company.quotations.paginate(:page => params[:page])
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
    @quotation = current_company.quotations.new(params[:quotation])
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
    redirect_to sales_quotation_path
  end  
  
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'quo'
  end
  
end
