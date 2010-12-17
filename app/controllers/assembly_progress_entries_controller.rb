class AssemblyProgressEntriesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  def index
    @search = current_company.assembly_progress_entries.search(params[:search])
    @assembly = current_company.trans_assemblies.find(params[:trans_assembly_id])
  end

  def new
    @assembly = current_company.trans_assemblies.find(params[:trans_assembly_id])
    @assembly.entries.each { |e| @assembly.progress_entries.build(:assembly_entry_id => e.assembly_id, :quantity => 0) }
  end

  def create
    @assembly = current_company.trans_assemblies.find(params[:trans_assembly_id])
    if @assembly.update_attributes(params[:trans_assembly])
      flash[:notice] = "Progress saved"
      redirect_to trans_assembly_assembly_progress_entries_path(@assembly)
    else
      render :new
    end
  end

  def edit
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'assy'
  end

end
