require File.dirname(__FILE__) + '/../spec_helper'

describe CustomerDownPaymentsController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => CustomerDownPayment.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    CustomerDownPayment.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    CustomerDownPayment.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(customer_down_payment_url(assigns[:customer_down_payment]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => CustomerDownPayment.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    CustomerDownPayment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CustomerDownPayment.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    CustomerDownPayment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CustomerDownPayment.first
    response.should redirect_to(customer_down_payment_url(assigns[:customer_down_payment]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    customer_down_payment = CustomerDownPayment.first
    delete :destroy, :id => customer_down_payment
    response.should redirect_to(customer_down_payments_url)
    CustomerDownPayment.exists?(customer_down_payment.id).should be_false
  end
end
