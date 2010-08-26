require File.dirname(__FILE__) + '/../spec_helper'
 
describe TransAssembliesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => TransAssembly.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    TransAssembly.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    TransAssembly.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(trans_assembly_url(assigns[:trans_assembly]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => TransAssembly.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    TransAssembly.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TransAssembly.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    TransAssembly.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TransAssembly.first
    response.should redirect_to(trans_assembly_url(assigns[:trans_assembly]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    trans_assembly = TransAssembly.first
    delete :destroy, :id => trans_assembly
    response.should redirect_to(trans_assemblies_url)
    TransAssembly.exists?(trans_assembly.id).should be_false
  end
end
