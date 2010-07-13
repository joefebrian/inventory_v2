class KursRatesController < ApplicationController
  before_filter :authenticate
   before_filter :assign_tab
  # GET /kurs_rates
  # GET /kurs_rates.xml
  def index
    @kurs_rates = KursRate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kurs_rates }
    end
  end

  # GET /kurs_rates/1
  # GET /kurs_rates/1.xml
  def show
    @kurs_rate = KursRate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kurs_rate }
    end
  end

  # GET /kurs_rates/new
  # GET /kurs_rates/new.xml
  def new
    @kurs_rate = KursRate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kurs_rate }
    end
  end

  # GET /kurs_rates/1/edit
  def edit
    @kurs_rate = KursRate.find(params[:id])
  end

  # POST /kurs_rates
  # POST /kurs_rates.xml
  def create
    @kurs_rate = KursRate.new(params[:kurs_rate])

    respond_to do |format|
      if @kurs_rate.save
        format.html { redirect_to(@kurs_rate, :notice => 'KursRate was successfully created.') }
        format.xml  { render :xml => @kurs_rate, :status => :created, :location => @kurs_rate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kurs_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kurs_rates/1
  # PUT /kurs_rates/1.xml
  def update
    @kurs_rate = KursRate.find(params[:id])

    respond_to do |format|
      if @kurs_rate.update_attributes(params[:kurs_rate])
        format.html { redirect_to(@kurs_rate, :notice => 'KursRate was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kurs_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kurs_rates/1
  # DELETE /kurs_rates/1.xml
  def destroy
    @kurs_rate = KursRate.find(params[:id])
    @kurs_rate.destroy

    respond_to do |format|
      format.html { redirect_to(kurs_rates_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def assign_tab
    @tab = 'administrations'
    @current = 'kursrate'
  end

end
