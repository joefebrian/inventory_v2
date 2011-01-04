class CreditDebitNotesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  load_and_authorize_resource
  load_and_authorize_resource :company, :through => :credit_debit_note
  
  def index
    @search = current_company.credit_debit_notes.search(params[:search])
    @credit_notes = @search.all(:conditions => { :credit => true }).paginate(:page => params[:credit])
    @debit_notes = @search.all(:conditions => { :credit => false }).paginate(:page => params[:debit])
  end
  
  def show
    @credit_debit_note = current_company.credit_debit_notes.find(params[:id])
  end
  
  def new
    @credit_debit_note = current_company.credit_debit_notes.new
    @credit_debit_note.credit = true
  end
  
  def create
    @credit_debit_note = current_company.credit_debit_notes.new(params[:credit_debit_note])
    if @credit_debit_note.save
      flash[:notice] = "Successfully created #{@credit_debit_note.credit? ? 'credit' : 'debit' } note."
      redirect_to @credit_debit_note
    else
      render :action => 'new'
    end
  end
  
  def edit
    @credit_debit_note = current_company.credit_debit_notes.find(params[:id])
  end
  
  def update
    @credit_debit_note = current_company.credit_debit_notes.find(params[:id])
    if @credit_debit_note.update_attributes(params[:credit_debit_note])
      flash[:notice] = "Successfully updated #{@credit_debit_note.credit? ? 'credit' : 'debit'} note."
      redirect_to @credit_debit_note
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @credit_debit_note = current_company.credit_debit_notes.find(params[:id])
    @credit_debit_note.destroy
    flash[:notice] = "Successfully destroyed credit debit note."
    redirect_to credit_debit_notes_url
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'cndn'
  end
end
