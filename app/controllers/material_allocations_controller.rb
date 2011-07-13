class MaterialAllocationsController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :through => :current_company

  # GET /material_allocations
  # GET /material_allocations.xml
  def index
    @material_allocations = MaterialAllocation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @material_allocations }
    end
  end

  # GET /material_allocations/1
  # GET /material_allocations/1.xml
  def show
    @material_allocation = MaterialAllocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @material_allocation }
    end
  end

  # GET /material_allocations/new
  # GET /material_allocations/new.xml
  def new
    @material_allocation = MaterialAllocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @material_allocation }
    end
  end

  # GET /material_allocations/1/edit
  def edit
    @material_allocation = MaterialAllocation.find(params[:id])
  end

  # POST /material_allocations
  # POST /material_allocations.xml
  def create
    @material_allocation = MaterialAllocation.new(params[:material_allocation])

    respond_to do |format|
      if @material_allocation.save
        format.html { redirect_to(@material_allocation, :notice => 'MaterialAllocation was successfully created.') }
        format.xml  { render :xml => @material_allocation, :status => :created, :location => @material_allocation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @material_allocation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /material_allocations/1
  # PUT /material_allocations/1.xml
  def update
    @material_allocation = MaterialAllocation.find(params[:id])

    respond_to do |format|
      if @material_allocation.update_attributes(params[:material_allocation])
        format.html { redirect_to(@material_allocation, :notice => 'MaterialAllocation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @material_allocation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /material_allocations/1
  # DELETE /material_allocations/1.xml
  def destroy
    @material_allocation = MaterialAllocation.find(params[:id])
    @material_allocation.destroy

    respond_to do |format|
      format.html { redirect_to(material_allocations_url) }
      format.xml  { head :ok }
    end
  end

  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
