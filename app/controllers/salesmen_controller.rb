class SalesmenController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @salesman = current_company.salesmen.paginate(:page => params[:page])
  end
  
  def show
    @salesman = current_company.salesmen.find(params[:id])
  end
  
  def new
    @salesman = current_company.salesmen.new
    @salesman.build_profile
  end
  
  def create
    @salesman = current_company.salesmen.new(params[:salesman])
    if @salesman.save
      flash[:notice] = "Successfully created salesman."
      redirect_to @salesman
    else
      render :action => 'new'
    end
  end
  
  def edit
    @salesman = current_company.Salesman.find(params[:id])
  end
  
  def update
    @salesman = current_company.Salesman.find(params[:id])
    if @salesman.update_attributes(params[:salesman])
      flash[:notice] = "Successfully updated salesman."
      redirect_to @salesman
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @salesman = current_company.Salesman.find(params[:id])
    @salesman.destroy
    flash[:notice] = "Successfully destroyed salesman."
    redirect_to salesmen_url
  end
  
  private
  def assign_tab
    @tab = 'administrations'
    @current = 'slm'
  end

end
