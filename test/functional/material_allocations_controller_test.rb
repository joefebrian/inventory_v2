require 'test_helper'

class MaterialAllocationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_allocations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_allocation" do
    assert_difference('MaterialAllocation.count') do
      post :create, :material_allocation => { }
    end

    assert_redirected_to material_allocation_path(assigns(:material_allocation))
  end

  test "should show material_allocation" do
    get :show, :id => material_allocations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => material_allocations(:one).to_param
    assert_response :success
  end

  test "should update material_allocation" do
    put :update, :id => material_allocations(:one).to_param, :material_allocation => { }
    assert_redirected_to material_allocation_path(assigns(:material_allocation))
  end

  test "should destroy material_allocation" do
    assert_difference('MaterialAllocation.count', -1) do
      delete :destroy, :id => material_allocations(:one).to_param
    end

    assert_redirected_to material_allocations_path
  end
end
