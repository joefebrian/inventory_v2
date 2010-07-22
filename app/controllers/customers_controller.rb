class CustomersController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  def index
    @customers = current_company.customers.paginate(:page => params[:page])
  end
  
  def show
    @customer = current_company.customers.find(params[:id])
  end
  
  def new
    @customer = current_company.customers.new
    @customer.build_profile
    @customer.build_tax_profile
  end
  
  def create
    @customer = current_company.customers.new(params[:customer])
    if @customer.save
      flash[:notice] = "Successfully created customer."
      redirect_to @customer
    else
      render :action => 'new'
    end
  end
  
  def edit
    @customer = current_company.customers.find(params[:id])
    @customer.build_profile if @customer.profile.nil?
    @customer.build_tax_profile if @customer.tax_profile.nil?
  end
  
  def update
    @customer = current_company.customers.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Successfully updated customer."
      redirect_to @customer
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @customer = current_company.customers.find(params[:id])
    @customer.destroy
    flash[:notice] = "Successfully destroyed customer."
    redirect_to customers_url
  end
  
    def search
    @keyword = params[:q]
    @customers = @keyword.nil? ? {} : current_company.customers.name_or_code_like(@keyword).all
    respond_to do |format|
      format.html { render :layout => false }
      format.js { 
        @html = render_to_string :partial => "customers_result"
        # render :layout => false
      }
    end
  end
  
  def picker
    @customers = Customer.id_in(params[:customers])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def set_tab
    @tab = 'administrations'
    @current = 'customer'
  end
end
