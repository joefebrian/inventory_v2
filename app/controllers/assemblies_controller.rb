class AssembliesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  before_filter :prepare_autocomplete, :only => [:new, :create, :edit, :update]
  load_and_authorize_resource

  def index 
    @search = current_company.assemblies.search(params[:search])
    @assemblies = @search.paginate(:page => params[:page])
  end

   def show
    @assembly = Assembly.find(params[:id])
  end 

  def new
    @assembly = current_company.assemblies.new
    @assembly.entries.build
    @assembly.number = Assembly.suggested_number(current_company)
    @category = current_company.categories.collect {|category| ["#{category.fullname}",category.id] if category.leaf?}.compact
  end  
  
  def create
    @assembly = current_company.assemblies.new(params[:assembly])
    if @assembly.save
      flash[:notice] = "Successfully created assembling."
      redirect_to assembly_path(@assembly)
    else
      @assembly.entries.build
      @category = current_company.categories.collect {|category| [category.name,category.id] if category.leaf?}.compact
      render :action => 'new'
    end
  end

 def edit
    @assembly = current_company.assemblies.find(params[:id])
    @assembly.entries.build
    @category = current_company.categories.collect {|category| [category.name,category.id] if category.leaf?}.compact
  end
  
  def update
    @assembly = current_company.assemblies.find(params[:id])
    if @assembly.update_attributes(params[:assembly])
      flash[:notice] = "Successfully updated  assembling."
      redirect_to assembly_path(@assembly)
    else
      render :action => 'edit'
      @category = current_company.categories.collect {|category| [category.name,category.id] if category.leaf?}.compact
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
