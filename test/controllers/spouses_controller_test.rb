require 'test_helper'

class SpousesControllerTest < ActionController::TestCase
  setup do
    @spouse = spouses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spouses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spouse" do
    assert_difference('Spouse.count') do
      post :create, spouse: { child_id: @spouse.child_id, dob: @spouse.dob, fullname: @spouse.fullname, gender: @spouse.gender }
    end

    assert_redirected_to spouse_path(assigns(:spouse))
  end

  test "should show spouse" do
    get :show, id: @spouse
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spouse
    assert_response :success
  end

  test "should update spouse" do
    patch :update, id: @spouse, spouse: { child_id: @spouse.child_id, dob: @spouse.dob, fullname: @spouse.fullname, gender: @spouse.gender }
    assert_redirected_to spouse_path(assigns(:spouse))
  end

  test "should destroy spouse" do
    assert_difference('Spouse.count', -1) do
      delete :destroy, id: @spouse
    end

    assert_redirected_to spouses_path
  end
end
