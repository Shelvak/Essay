require 'test_helper'

class ClientsControllerTest < ActionController::TestCase

  setup do
    @client = Fabricate(:client)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
    assert_select '#unexpected_error', false
    assert_template "clients/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:client)
    assert_select '#unexpected_error', false
    assert_template "clients/new"
  end

  test "should create client" do
    assert_difference('Client.count') do
      post :create, params: { client: Fabricate.attributes_for(:client) }
    end

    assert_redirected_to client_url(assigns(:client))
  end

  test "should show client" do
    get :show, params: { id: @client }
    assert_response :success
    assert_not_nil assigns(:client)
    assert_select '#unexpected_error', false
    assert_template "clients/show"
  end

  test "should get edit" do
    get :edit, params: { id: @client }
    assert_response :success
    assert_not_nil assigns(:client)
    assert_select '#unexpected_error', false
    assert_template "clients/edit"
  end

  test "should update client" do
    put :update, params: { id: @client,
      client: Fabricate.attributes_for(:client, attr: 'value') }
    assert_redirected_to client_url(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, params: { id: @client }
    end

    assert_redirected_to clients_url
  end
end
