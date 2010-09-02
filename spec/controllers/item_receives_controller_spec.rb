require File.dirname(__FILE__) + '/../spec_helper'
 
describe ItemReceivesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => ItemReceive.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    ItemReceive.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ItemReceive.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(item_receive_url(assigns[:item_receive]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => ItemReceive.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    ItemReceive.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ItemReceive.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ItemReceive.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ItemReceive.first
    response.should redirect_to(item_receive_url(assigns[:item_receive]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    item_receive = ItemReceive.first
    delete :destroy, :id => item_receive
    response.should redirect_to(item_receives_url)
    ItemReceive.exists?(item_receive.id).should be_false
  end
end
