class KursIdsController < ApplicationController
   before_filter :authenticate
   before_filter :assign_tab
  # GET /kurs_ids
   #GET /kurs_ids.xml
  
   def index
    @kurs_ids = KursId.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kurs_ids }
    end
  end

  # GET /kurs_ids/1
  # GET /kurs_ids/1.xml
  def show
    @kurs_id = KursId.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kurs_id }
    end
  end

  # GET /kurs_ids/new
  # GET /kurs_ids/new.xml
  def new
    @kurs_id = KursId.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kurs_id }
    end
  end

  # GET /kurs_ids/1/edit
  def edit
    @kurs_id = KursId.find(params[:id])
  end

  # POST /kurs_ids
  # POST /kurs_ids.xml
  def create
    @kurs_id = KursId.new(params[:kurs_id])

    respond_to do |format|
      if @kurs_id.save
        format.html { redirect_to(@kurs_id, :notice => 'KursId was successfully created.') }
        format.xml  { render :xml => @kurs_id, :status => :created, :location => @kurs_id }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kurs_id.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kurs_ids/1
  # PUT /kurs_ids/1.xml
  def update
    @kurs_id = KursId.find(params[:id])

    respond_to do |format|
      if @kurs_id.update_attributes(params[:kurs_id])
        format.html { redirect_to(@kurs_id, :notice => 'KursId was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kurs_id.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kurs_ids/1
  # DELETE /kurs_ids/1.xml
  def destroy
    @kurs_id = KursId.find(params[:id])
    @kurs_id.destroy

    respond_to do |format|
      format.html { redirect_to(kurs_ids_url) }
      format.xml  { head :ok }
    end
  end
 
  private
  def assign_tab
    @tab = 'administrations'
    @current = 'kursid'
  end

end
