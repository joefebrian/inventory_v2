class QuotationEntriesController < ApplicationController
  # GET /quotation_entries
  # GET /quotation_entries.xml
  def index
    @quotation_entries = QuotationEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quotation_entries }
    end
  end

  # GET /quotation_entries/1
  # GET /quotation_entries/1.xml
  def show
    @quotation_entry = QuotationEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quotation_entry }
    end
  end

  # GET /quotation_entries/new
  # GET /quotation_entries/new.xml
  def new
    @quotation_entry = QuotationEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quotation_entry }
    end
  end

  # GET /quotation_entries/1/edit
  def edit
    @quotation_entry = QuotationEntry.find(params[:id])
  end

  # POST /quotation_entries
  # POST /quotation_entries.xml
  def create
    @quotation_entry = QuotationEntry.new(params[:quotation_entry])

    respond_to do |format|
      if @quotation_entry.save
        format.html { redirect_to(@quotation_entry, :notice => 'QuotationEntry was successfully created.') }
        format.xml  { render :xml => @quotation_entry, :status => :created, :location => @quotation_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quotation_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quotation_entries/1
  # PUT /quotation_entries/1.xml
  def update
    @quotation_entry = QuotationEntry.find(params[:id])

    respond_to do |format|
      if @quotation_entry.update_attributes(params[:quotation_entry])
        format.html { redirect_to(@quotation_entry, :notice => 'QuotationEntry was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quotation_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quotation_entries/1
  # DELETE /quotation_entries/1.xml
  def destroy
    @quotation_entry = QuotationEntry.find(params[:id])
    @quotation_entry.destroy

    respond_to do |format|
      format.html { redirect_to(quotation_entries_url) }
      format.xml  { head :ok }
    end
  end
end
