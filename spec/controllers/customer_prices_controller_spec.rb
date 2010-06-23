require File.dirname(__FILE__) + '/../spec_helper'
 
describe CustomerPricesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => CustomerPrice.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    CustomerPrice.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    CustomerPrice.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(customer_price_url(assigns[:customer_price]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => CustomerPrice.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    CustomerPrice.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CustomerPrice.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    CustomerPrice.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CustomerPrice.first
    response.should redirect_to(customer_price_url(assigns[:customer_price]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    customer_price = CustomerPrice.first
    delete :destroy, :id => customer_price
    response.should redirect_to(customer_prices_url)
    CustomerPrice.exists?(customer_price.id).should be_false
  end
end
