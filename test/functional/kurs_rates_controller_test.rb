require 'test_helper'

class KursRatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kurs_rates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kurs_rate" do
    assert_difference('KursRate.count') do
      post :create, :kurs_rate => { }
    end

    assert_redirected_to kurs_rate_path(assigns(:kurs_rate))
  end

  test "should show kurs_rate" do
    get :show, :id => kurs_rates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => kurs_rates(:one).to_param
    assert_response :success
  end

  test "should update kurs_rate" do
    put :update, :id => kurs_rates(:one).to_param, :kurs_rate => { }
    assert_redirected_to kurs_rate_path(assigns(:kurs_rate))
  end

  test "should destroy kurs_rate" do
    assert_difference('KursRate.count', -1) do
      delete :destroy, :id => kurs_rates(:one).to_param
    end

    assert_redirected_to kurs_rates_path
  end
end
