require File.dirname(__FILE__) + '/../spec_helper'
 
describe SalesInvoicesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => SalesInvoice.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    SalesInvoice.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    SalesInvoice.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(sales_invoice_url(assigns[:sales_invoice]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => SalesInvoice.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    SalesInvoice.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SalesInvoice.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    SalesInvoice.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SalesInvoice.first
    response.should redirect_to(sales_invoice_url(assigns[:sales_invoice]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    sales_invoice = SalesInvoice.first
    delete :destroy, :id => sales_invoice
    response.should redirect_to(sales_invoices_url)
    SalesInvoice.exists?(sales_invoice.id).should be_false
  end
end
