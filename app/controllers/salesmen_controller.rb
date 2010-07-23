class SalesmenController < ApplicationController
  def index
    @salesmen = Salesman.all
  end
  
  def show
    @salesman = Salesman.find(params[:id])
  end
  
  def new
    @salesman = Salesman.new
  end
  
  def create
    @salesman = Salesman.new(params[:salesman])
    if @salesman.save
      flash[:notice] = "Successfully created salesman."
      redirect_to @salesman
    else
      render :action => 'new'
    end
  end
  
  def edit
    @salesman = Salesman.find(params[:id])
  end
  
  def update
    @salesman = Salesman.find(params[:id])
    if @salesman.update_attributes(params[:salesman])
      flash[:notice] = "Successfully updated salesman."
      redirect_to @salesman
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @salesman = Salesman.find(params[:id])
    @salesman.destroy
    flash[:notice] = "Successfully destroyed salesman."
    redirect_to salesmen_url
  end
end
