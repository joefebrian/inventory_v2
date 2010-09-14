class ItemsController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  before_filter :categories_list
  load_and_authorize_resource

  def index
    if params[:category_id]
      @items = current_company.categories.id_is(params[:category_id]).first.items.searchlogic
    else
      @items = current_company.items.searchlogic
    end
    @active = params[:active] || 1
    @items = @items.active_is(@active) unless (@active.blank? || @active == 'all')
    @items = @items.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.xml { render :xml => @items }
      format.json { render :json => @items }
    end
  end
  
  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { render :layout => false if request.xhr? }
      format.xml { render :xml => @item.to_xml(:include  => :units) }
      format.json { render :json => @item.to_json(:include  => :units) }
    end
  end
  
  def new
    @item = Item.new
    @item.is_stock = true
    @item.units.build(:name => 'unit', :conversion_rate => 1)
    @item.units.build
    @item.units.build
    @categories = current_company.leaf_categories.collect { |cat| [cat.fullcode, cat.id] }.compact
    render :layout => false if request.xhr?
  end
  
  def create
    @item = Item.new(params[:item])
    @item.company = current_company
    if @item.save
      flash[:notice] = "Successfully created item."
      if request.xhr?
        render :json => { 'location' => items_path}.to_json, :layout => false
      else
        redirect_to items_path
      end
    else
      if request.xhr?
        form = render_to_string :action => 'new', :layout => false
        status = 'validation error'
        render :json => {'status' => status, 'form' => form }.to_json
      else
        @categories = current_company.leaf_categories.collect { |cat| [cat.fullcode, cat.id] }.compact
        (3 - @item.units.length).times { @item.units.build } if @item.units.length < 3
        render :action => 'new'
      end
    end
  end
  
  def edit
    @item = Item.find(params[:id])
    @item.units.build(:name => 'unit', :conversion_rate => 1) if @item.units.length < 1
    @categories = current_company.leaf_categories.collect { |cat| [cat.fullcode, cat.id] }.compact
    render :layout => false if request.xhr?
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = "Successfully updated item."
      if request.xhr?
        render :json => { 'location' => items_path}.to_json, :layout => false
      else
        redirect_to items_path
      end
    else
      if request.xhr?
        form = render_to_string :action => 'edit', :layout => false
        status = 'validation error'
        render :json => {'status' => status, 'form' => form }.to_json
      else
        @item.units.build(:name => 'unit', :conversion_rate => 1) if @item.units.length < 1
        @categories = current_company.leaf_categories.collect { |cat| [cat.fullcode, cat.id] }.compact
        render :action => 'edit'
      end
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Successfully destroyed item."
    redirect_to items_url
  end

  def lookup
    @keyword = params[:keyword]
    @items = @keyword.nil? ? {} : current_company.items.name_or_code_or_plus_code_like(@keyword).all(:group => 'items.id')
    respond_to do |format|
      format.html
      format.js do
        if @keyword
          render :partial => 'searchresult', :layout => false
        else
          render :layout => false
        end
      end
    end
  end

  def search
    @keyword = params[:term]
    @items = @keyword.nil? ? {} : current_company.items.name_or_code_like(@keyword).all(:limit => 10)
    respond_to do |format|
      format.html { render :layout => false }
      format.js { 
        @html = render_to_string :partial => "items_result"
      }
    end
  end
  
  def picker
    @items = Item.id_in(params[:items])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def activate
    item = Item.find(params[:id])
    item.update_attributes(:active => true)
    redirect_to :back
  end

  def deactivate
    item = Item.find(params[:id])
    item.update_attributes(:active => false)
    redirect_to :back
  end

  private
  def set_tab
    @tab = 'administrations'
    @current = 'it'
  end

  def categories_list
    @categories_list = leaf_categories
  end
end
