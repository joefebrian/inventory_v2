require 'test_helper'

class KursIdsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kurs_ids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kurs_id" do
    assert_difference('KursId.count') do
      post :create, :kurs_id => { }
    end

    assert_redirected_to kurs_id_path(assigns(:kurs_id))
  end

  test "should show kurs_id" do
    get :show, :id => kurs_ids(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => kurs_ids(:one).to_param
    assert_response :success
  end

  test "should update kurs_id" do
    put :update, :id => kurs_ids(:one).to_param, :kurs_id => { }
    assert_redirected_to kurs_id_path(assigns(:kurs_id))
  end

  test "should destroy kurs_id" do
    assert_difference('KursId.count', -1) do
      delete :destroy, :id => kurs_ids(:one).to_param
    end

    assert_redirected_to kurs_ids_path
  end
end
