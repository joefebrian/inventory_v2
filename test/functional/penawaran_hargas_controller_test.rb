require 'test_helper'

class PenawaranHargasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:penawaran_hargas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create penawaran_harga" do
    assert_difference('PenawaranHarga.count') do
      post :create, :penawaran_harga => { }
    end

    assert_redirected_to penawaran_harga_path(assigns(:penawaran_harga))
  end

  test "should show penawaran_harga" do
    get :show, :id => penawaran_hargas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => penawaran_hargas(:one).to_param
    assert_response :success
  end

  test "should update penawaran_harga" do
    put :update, :id => penawaran_hargas(:one).to_param, :penawaran_harga => { }
    assert_redirected_to penawaran_harga_path(assigns(:penawaran_harga))
  end

  test "should destroy penawaran_harga" do
    assert_difference('PenawaranHarga.count', -1) do
      delete :destroy, :id => penawaran_hargas(:one).to_param
    end

    assert_redirected_to penawaran_hargas_path
  end
end
