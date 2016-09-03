require 'test_helper'

class EssaysControllerTest < ActionController::TestCase

  setup do
    @essay = Fabricate(:essay)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:essays)
    assert_select '#unexpected_error', false
    assert_template "essays/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:essay)
    assert_select '#unexpected_error', false
    assert_template "essays/new"
  end

  test "should create essay" do
    assert_difference('Essay.count') do
      post :create, params: { essay: Fabricate.attributes_for(:essay) }
    end

    assert_redirected_to essay_url(assigns(:essay))
  end

  test "should show essay" do
    get :show, params: { id: @essay }
    assert_response :success
    assert_not_nil assigns(:essay)
    assert_select '#unexpected_error', false
    assert_template "essays/show"
  end

  test "should get edit" do
    get :edit, params: { id: @essay }
    assert_response :success
    assert_not_nil assigns(:essay)
    assert_select '#unexpected_error', false
    assert_template "essays/edit"
  end

  test "should update essay" do
    put :update, params: { id: @essay,
      essay: Fabricate.attributes_for(:essay, attr: 'value') }
    assert_redirected_to essay_url(assigns(:essay))
  end

  test "should destroy essay" do
    assert_difference('Essay.count', -1) do
      delete :destroy, params: { id: @essay }
    end

    assert_redirected_to essays_url
  end
end
