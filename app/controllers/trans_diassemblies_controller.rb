class TransDiassembliesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource

  def index
    @trans_diassemblies = current_company.trans_diassemblies.all
  end
 
  def show
    @trans_diassembly = current_company.trans_diassemblies.find(params[:id])
  end
  
  def new
    @trans_diassembly = current_company.trans_diassemblies.new
    @trans_diassembly.entries.build
    @warehouses = current_company.warehouses
    @trans_assemblies = current_company.trans_assemblies
  end
 
  def create
    @trans_diassembly = current_company.trans_diassemblies.new(params[:trans_diassembly])
    if params[:get_trads] && params[:get_trads].to_i == 1
      @trans_diassembly.build_entries_from_trad
      @trans_assemblies = current_company.trans_assemblies
      @trans_diassembly.entries.build
      render("new", :layout => false) and return
    end
    if @trans_diassembly.save
      flash[:notice] = "Successfully created trans diassembling."
      redirect_to @trans_diassembly
    else
      @trans_diassembly.entries.build
      @warehouses = current_company.warehouses
      @assemblies = current_company.assemblies
      render :action => 'new'
    end
  end

  def edit
    @trans_diassembly = current_company.trans_diassemblies.find(params[:id])
  end
  
  def update
    @trans_diassembly = current_company.trans_diassemblies.find(params[:id])
    if @trans_diassembly.update_attributes(params[:trans_diassembly])
      flash[:notice] = "Successfully updated trans diassembly."
      redirect_to @trans_diassembly
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @trans_diassembly = current_company.trans_diassemblies.find(params[:id])
    @trans_diassembly.destroy
    flash[:notice] = "Successfully destroyed trans diassembly."
    redirect_to trans_diassemblies_url
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'assy'
  end

end
