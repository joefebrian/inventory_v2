require File.dirname(__FILE__) + '/../spec_helper'

describe CreditDebitNotesController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => CreditDebitNote.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    CreditDebitNote.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    CreditDebitNote.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(credit_debit_note_url(assigns[:credit_debit_note]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => CreditDebitNote.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    CreditDebitNote.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CreditDebitNote.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    CreditDebitNote.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CreditDebitNote.first
    response.should redirect_to(credit_debit_note_url(assigns[:credit_debit_note]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    credit_debit_note = CreditDebitNote.first
    delete :destroy, :id => credit_debit_note
    response.should redirect_to(credit_debit_notes_url)
    CreditDebitNote.exists?(credit_debit_note.id).should be_false
  end
end
