class Project::SpksController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :class => "Project::Spk", :through => :current_company
  # GET /project_spks
  # GET /project_spks.xml
  def index
    @search = current_company.spks.search(params[:search])
    @spks = @search.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_spks }
    end
  end

  # GET /project_spks/1
  # GET /project_spks/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spk }
    end
  end

  # GET /project_spks/new
  # GET /project_spks/new.xml
  def new
    @spk = current_company.spks.build
    @spk.generate_next_number
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spk }
    end
  end

  # GET /project_spks/1/edit
  def edit
  end

  # POST /project_spks
  # POST /project_spks.xml
  def create
    @spk = current_company.spks.build
    @spk.generate_next_number
    @spk.attributes = (params[:project_spk])

    respond_to do |format|
      if @spk.save
        format.html { redirect_to(@spk, :notice => 'Project::Spk was successfully created.') }
        format.xml  { render :xml => @spk, :status => :created, :location => @spk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project_spks/1
  # PUT /project_spks/1.xml
  def update
    @spk = Project::Spk.find(params[:id])

    respond_to do |format|
      if @spk.update_attributes(params[:project_spk])
        format.html { redirect_to(@spk, :notice => 'Project::Spk was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_spks/1
  # DELETE /project_spks/1.xml
  def destroy
    @spk = Project::Spk.find(params[:id])
    @spk.destroy

    respond_to do |format|
      format.html { redirect_to(project_spks_url) }
      format.xml  { head :ok }
    end
  end

  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end

end
