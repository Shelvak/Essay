require 'test_helper'

class ShiftsControllerTest < ActionController::TestCase

  setup do
    @shift = Fabricate(:shift)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shifts)
    assert_select '#unexpected_error', false
    assert_template "shifts/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:shift)
    assert_select '#unexpected_error', false
    assert_template "shifts/new"
  end

  test "should create shift" do
    assert_difference('Shift.count') do
      post :create, params: { shift: Fabricate.attributes_for(:shift) }
    end

    assert_redirected_to shift_url(assigns(:shift))
  end

  test "should show shift" do
    get :show, params: { id: @shift }
    assert_response :success
    assert_not_nil assigns(:shift)
    assert_select '#unexpected_error', false
    assert_template "shifts/show"
  end

  test "should get edit" do
    get :edit, params: { id: @shift }
    assert_response :success
    assert_not_nil assigns(:shift)
    assert_select '#unexpected_error', false
    assert_template "shifts/edit"
  end

  test "should update shift" do
    put :update, params: { id: @shift,
      shift: Fabricate.attributes_for(:shift, attr: 'value') }
    assert_redirected_to shift_url(assigns(:shift))
  end

  test "should destroy shift" do
    assert_difference('Shift.count', -1) do
      delete :destroy, params: { id: @shift }
    end

    assert_redirected_to shifts_url
  end
end
