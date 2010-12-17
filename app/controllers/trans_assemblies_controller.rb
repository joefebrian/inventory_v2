class TransAssembliesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  
  def index
    @search = current_company.trans_assemblies.search(params[:search])
    @trans_assemblies = @search.paginate(:page => params[:page])
  end
 
  def show
    @trans_assembly = current_company.trans_assemblies.find(params[:id])
  end
  
  def new
    @trans_assembly = current_company.trans_assemblies.new(:quantity => 1, :date => Time.now.to_date)
    @trans_assembly.entries.build
    @warehouses = current_company.warehouses
    @assemblies = current_company.assemblies
  end
  
  def create
    @trans_assembly = current_company.trans_assemblies.new(params[:trans_assembly])
    @assemblies = current_company.assemblies
    if params[:get_ones] && params[:get_ones].to_i == 1
      @trans_assembly.build_entries_from_assembly
      render("new", :layout => false) and return
    end
    if @trans_assembly.save
      flash[:notice] = "Successfully created trans assembly."
      redirect_to @trans_assembly
    else
      @warehouses = current_company.warehouses
      render :action => 'new'
    end
  end
  
  def edit
    @trans_assembly = current_company.trans_assemblies.find(params[:id])
    @trans_assembly.entries.build
    @warehouses = current_company.warehouses
    @assemblies = current_company.assemblies
  end
  
  def update
    @trans_assembly = current_company.trans_assembly.find(params[:id])
    if @trans_assembly.update_attributes(params[:trans_assembly])
      flash[:notice] = "Successfully updated trans assembly."
      redirect_to @trans_assembly
    else
      @trans_assembly.entries.build
      @warehouses = current_company.warehouses
      @assemblies = current_company.assemblies
      render :action => 'edit'
    end
  end
  
  def destroy
    @trans_assembly = current_company.trans_assembly.find(params[:id])
    @trans_assembly.destroy
    flash[:notice] = "Successfully destroyed trans assembly."
    redirect_to trans_assemblies_url
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'assy'
  end

end
