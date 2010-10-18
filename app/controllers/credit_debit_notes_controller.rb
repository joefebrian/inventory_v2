class CreditDebitNotesController < ApplicationController
  def index
    @credit_debit_notes = CreditDebitNote.all
  end
  
  def show
    @credit_debit_note = CreditDebitNote.find(params[:id])
  end
  
  def new
    @credit_debit_note = CreditDebitNote.new
  end
  
  def create
    @credit_debit_note = CreditDebitNote.new(params[:credit_debit_note])
    if @credit_debit_note.save
      flash[:notice] = "Successfully created credit debit note."
      redirect_to @credit_debit_note
    else
      render :action => 'new'
    end
  end
  
  def edit
    @credit_debit_note = CreditDebitNote.find(params[:id])
  end
  
  def update
    @credit_debit_note = CreditDebitNote.find(params[:id])
    if @credit_debit_note.update_attributes(params[:credit_debit_note])
      flash[:notice] = "Successfully updated credit debit note."
      redirect_to @credit_debit_note
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @credit_debit_note = CreditDebitNote.find(params[:id])
    @credit_debit_note.destroy
    flash[:notice] = "Successfully destroyed credit debit note."
    redirect_to credit_debit_notes_url
  end
end
