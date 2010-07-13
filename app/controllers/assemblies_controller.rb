class AssembliesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  before_filter :prepare_autocomplete, :only => [:new, :create, :edit, :update]

  def index 
    @assemblies = current_company.assemblies
  end

  def show
    @assembly = Assembly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assembly }
    end
  end

  def new
    @assembly = Assembly.new
    @assembly.number = Assembly.suggested_number(current_company)
  end

  def edit
    @assembly = Assembly.find(params[:id])
  end

  def create
    @assembly = Assembly.new(params[:assembly])

    respond_to do |format|
      if @assembly.save
        format.html { redirect_to(@assembly, :notice => 'Assembly was successfully created.') }
        format.xml  { render :xml => @assembly, :status => :created, :location => @assembly }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assembly.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @assembly = Assembly.find(params[:id])

    respond_to do |format|
      if @assembly.update_attributes(params[:assembly])
        format.html { redirect_to(@assembly, :notice => 'Assembly was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assembly.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @assembly = Assembly.find(params[:id])
    @assembly.destroy

    respond_to do |format|
      format.html { redirect_to(assemblies_url) }
      format.xml  { head :ok }
    end
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
