class QuotationsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  before_filter :prepare_autocomplete, :only => [:new, :create, :edit, :update]

  def index
    @quotations = Quotation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quotations }
    end
  end

  def show
    @quotation = Quotation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quotation }
    end
  end

  def new
    @quotation = Quotation.new
    @quotation.number = Quotation.suggested_number(current_company)
  end

  def edit
    @quotation = Quotation.find(params[:id])
  end

  def create
    @quotation = Quotation.new(params[:quotation])

    respond_to do |format|
      if @quotation.save
        format.html { redirect_to(@quotation, :notice => 'Quotation was successfully created.') }
        format.xml  { render :xml => @quotation, :status => :created, :location => @quotation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quotations/1
  # PUT /quotations/1.xml
  def update
    @quotation = Quotation.find(params[:id])

    respond_to do |format|
      if @quotation.update_attributes(params[:quotation])
        format.html { redirect_to(@quotation, :notice => 'Quotation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.xml
  def destroy
    @quotation = Quotation.find(params[:id])
    @quotation.destroy

    respond_to do |format|
      format.html { redirect_to(quotations_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def assign_tab
    @tab = 'transactions'
    @current = 'quo'
  end
  
  def prepare_autocomplete
    @items = current_company.items
  end

end
