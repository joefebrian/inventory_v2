class DirectSalesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource
  load_and_authorize_resource :company, :through => :direct_sale

  def index
    @search = current_company.direct_sales.search(params[:search])
    @direct_sales = @search.paginate(:page => params[:page])
  end

  def show
    @direct_sale = current_company.direct_sales.find(params[:id])
      respond_to do |format|
        if(params[:type])
            format.html { render "print", :layout => "print"}
        else
            format.html { render "show", :layout => "application"}
        end
      end
  end

  def new
    @direct_sale = current_company.direct_sales.new
    @direct_sale.entries.build
    @customer = current_company.customers
  end

  def create
    @direct_sale = current_company.direct_sales.new(params[:direct_sale])
    if @direct_sale.save
      flash[:notice] = "Successfully created Direct Sales."
      redirect_to direct_sale_path(@direct_sale)
    else
      @direct_sale.entries.build
      render :action => 'new'
    end
  end

  def edit
    @direct_sale = current_company.direct_sales.find(params[:id])
    @direct_sale.entries.build
  end

  def update
    @direct_sale = current_company.direct_sales.find(params[:id])
    if @direct_sale.update_attributes(params[:direct_sale])
      flash[:notice] = "Successfully updated Direct Sales."
      redirect_to direct_sale_path(@direct_sale)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @direct_sale = current_company.direct_sales.find(params[:id])
    @direct_sale.destroy
    flash[:notice] = "Successfully destroyed Direct Sales."
    redirect_to direct_sale_url
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'ds'
  end

end

