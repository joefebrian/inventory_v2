class PenawaranHargasController < ApplicationController
  # GET /penawaran_hargas
  # GET /penawaran_hargas.xml
  def index
    @penawaran_hargas = PenawaranHarga.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @penawaran_hargas }
    end
  end

  # GET /penawaran_hargas/1
  # GET /penawaran_hargas/1.xml
  def show
    @penawaran_harga = PenawaranHarga.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @penawaran_harga }
    end
  end

  # GET /penawaran_hargas/new
  # GET /penawaran_hargas/new.xml
  def new
    @penawaran_harga = PenawaranHarga.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @penawaran_harga }
    end
  end

  # GET /penawaran_hargas/1/edit
  def edit
    @penawaran_harga = PenawaranHarga.find(params[:id])
  end

  # POST /penawaran_hargas
  # POST /penawaran_hargas.xml
  def create
    @penawaran_harga = PenawaranHarga.new(params[:penawaran_harga])

    respond_to do |format|
      if @penawaran_harga.save
        format.html { redirect_to(@penawaran_harga, :notice => 'PenawaranHarga was successfully created.') }
        format.xml  { render :xml => @penawaran_harga, :status => :created, :location => @penawaran_harga }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @penawaran_harga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /penawaran_hargas/1
  # PUT /penawaran_hargas/1.xml
  def update
    @penawaran_harga = PenawaranHarga.find(params[:id])

    respond_to do |format|
      if @penawaran_harga.update_attributes(params[:penawaran_harga])
        format.html { redirect_to(@penawaran_harga, :notice => 'PenawaranHarga was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @penawaran_harga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /penawaran_hargas/1
  # DELETE /penawaran_hargas/1.xml
  def destroy
    @penawaran_harga = PenawaranHarga.find(params[:id])
    @penawaran_harga.destroy

    respond_to do |format|
      format.html { redirect_to(penawaran_hargas_url) }
      format.xml  { head :ok }
    end
  end
end
