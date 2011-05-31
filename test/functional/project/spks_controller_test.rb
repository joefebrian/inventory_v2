require 'test_helper'

class Project::SpksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_spks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spk" do
    assert_difference('Project::Spk.count') do
      post :create, :spk => { }
    end

    assert_redirected_to spk_path(assigns(:spk))
  end

  test "should show spk" do
    get :show, :id => project_spks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => project_spks(:one).to_param
    assert_response :success
  end

  test "should update spk" do
    put :update, :id => project_spks(:one).to_param, :spk => { }
    assert_redirected_to spk_path(assigns(:spk))
  end

  test "should destroy spk" do
    assert_difference('Project::Spk.count', -1) do
      delete :destroy, :id => project_spks(:one).to_param
    end

    assert_redirected_to project_spks_path
  end
end
