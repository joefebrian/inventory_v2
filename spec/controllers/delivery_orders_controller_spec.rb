require File.dirname(__FILE__) + '/../spec_helper'
 
describe DeliveryOrdersController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => DeliveryOrder.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    DeliveryOrder.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    DeliveryOrder.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(delivery_order_url(assigns[:delivery_order]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => DeliveryOrder.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    DeliveryOrder.any_instance.stubs(:valid?).returns(false)
    put :update, :id => DeliveryOrder.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    DeliveryOrder.any_instance.stubs(:valid?).returns(true)
    put :update, :id => DeliveryOrder.first
    response.should redirect_to(delivery_order_url(assigns[:delivery_order]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    delivery_order = DeliveryOrder.first
    delete :destroy, :id => delivery_order
    response.should redirect_to(delivery_orders_url)
    DeliveryOrder.exists?(delivery_order.id).should be_false
  end
end
