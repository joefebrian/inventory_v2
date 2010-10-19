require File.dirname(__FILE__) + '/../spec_helper'
 
describe DownPaymentCustomersController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => DownPaymentCustomer.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    DownPaymentCustomer.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    DownPaymentCustomer.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(down_payment_customer_url(assigns[:down_payment_customer]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => DownPaymentCustomer.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    DownPaymentCustomer.any_instance.stubs(:valid?).returns(false)
    put :update, :id => DownPaymentCustomer.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    DownPaymentCustomer.any_instance.stubs(:valid?).returns(true)
    put :update, :id => DownPaymentCustomer.first
    response.should redirect_to(down_payment_customer_url(assigns[:down_payment_customer]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    down_payment_customer = DownPaymentCustomer.first
    delete :destroy, :id => down_payment_customer
    response.should redirect_to(down_payment_customers_url)
    DownPaymentCustomer.exists?(down_payment_customer.id).should be_false
  end
end
