class PriceListsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource
  # GET /price_lists
  # GET /price_lists.xml
  def index
    @search = current_company.price_lists.search(params[:search])
    @price_lists = @search.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @price_lists }
    end
  end

  # GET /price_lists/1
  # GET /price_lists/1.xml
  def show
    @price_list = PriceList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @price_list }
    end
  end

  # GET /price_lists/new
  # GET /price_lists/new.xml
  def new
    @price_list = current_company.price_lists.new
    if params[:items]
      for id in params[:items]
        item = current_company.items.find(id)
        for unit in item.units
          @price_list.entries.build(:item_id => item.id, :unit_id => unit.id, :value => unit.value)
        end
      end
    end
    #@items = current_company.items.all(:include => :units, :order => "name").paginate(:page => params[:page])
    #for item in @items
    #  for unit in item.units
    #    @price_list.entries.build(:item_id => item.id, :unit_id => unit.id, :value => 0)
    #  end
    #end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @price_list }
    end
  end

  # GET /price_lists/1/edit
  def edit
    @price_list = PriceList.find(params[:id])
  end

  # POST /price_lists
  # POST /price_lists.xml
  def create
    @price_list = current_company.price_lists.new(params[:price_list])
    unless !request.xhr? && params[:item_getter].blank?
      @item = current_company.items.find_by_name(params[:item_getter])
      for unit in @item.units
        @price_list.entries.build(:item_id => @item.id, :unit_id => unit.id, :value => unit.value)
      end
      render("new", :layout => false) and return
    end

    respond_to do |format|
      if @price_list.save
        format.html { redirect_to(@price_list, :notice => 'PriceList was successfully created.') }
        format.xml  { render :xml => @price_list, :status => :created, :location => @price_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @price_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /price_lists/1
  # PUT /price_lists/1.xml
  def update
    @price_list = PriceList.find(params[:id])
    unless !request.xhr? && params[:item_getter].blank?
      @item = current_company.items.find_by_name(params[:item_getter])
      for unit in @item.units
        @price_list.entries.build(:item_id => @item.id, :unit_id => unit.id, :value => unit.value)
      end
      render("edit", :layout => false) and return
    end

    respond_to do |format|
      if @price_list.update_attributes(params[:price_list])
        format.html { redirect_to(@price_list, :notice => 'PriceList was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @price_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /price_lists/1
  # DELETE /price_lists/1.xml
  def destroy
    @price_list = PriceList.find(params[:id])
    @price_list.destroy

    respond_to do |format|
      format.html { redirect_to(price_lists_url) }
      format.xml  { head :ok }
    end
  end

  def assign_tab
    @tab = 'administrations'
    @current = 'price_list'
  end
end
