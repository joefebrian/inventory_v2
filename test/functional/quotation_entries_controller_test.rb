require 'test_helper'

class QuotationEntriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotation_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quotation_entry" do
    assert_difference('QuotationEntry.count') do
      post :create, :quotation_entry => { }
    end

    assert_redirected_to quotation_entry_path(assigns(:quotation_entry))
  end

  test "should show quotation_entry" do
    get :show, :id => quotation_entries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => quotation_entries(:one).to_param
    assert_response :success
  end

  test "should update quotation_entry" do
    put :update, :id => quotation_entries(:one).to_param, :quotation_entry => { }
    assert_redirected_to quotation_entry_path(assigns(:quotation_entry))
  end

  test "should destroy quotation_entry" do
    assert_difference('QuotationEntry.count', -1) do
      delete :destroy, :id => quotation_entries(:one).to_param
    end

    assert_redirected_to quotation_entries_path
  end
end
