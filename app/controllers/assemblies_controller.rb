class AssembliesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  before_filter :prepare_autocomplete, :only => [:new, :create, :edit, :update]

  def index 
    @assemblies = current_company.assemblies
  end

   def show
    @assembly = Assembly.find(params[:id])
  end 

  def new
    @assembly = current_company.assemblies.new
    @assembly.entries.build
    @assembly.number = Assembly.suggested_number(current_company)
  end  
  
  def create
    @assembly = current_company.assemblies.new(params[:assembly])
    if @assembly.save
      flash[:notice] = "Successfully created assembling."
      redirect_to assembly_path(@assembly)
    else
      render :action => 'new'
    end
  end

 def edit
    @assembly = current_company.assemblies.find(params[:id])
    @assembly.entries.build
  end
  
  def update
    @assembly = current_company.assemblies.find(params[:id])
    if @assembly.update_attributes(params[:assembly])
      flash[:notice] = "Successfully updated  assembling."
      redirect_to assembly_path(@assembly)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @assembly = current_company.assemblies.find(params[:id])
    @assembly.destroy
    flash[:notice] = "Successfully destroyed assembling."
    redirect_to assembly_url
  end 
  
  private
  def assign_tab
    @tab = 'administrations'
    @current = 'ass'
  end
  
  def prepare_autocomplete
    @items = current_company.items
  end

end
