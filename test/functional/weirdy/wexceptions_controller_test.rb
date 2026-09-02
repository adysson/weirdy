require 'test_helper'

module Weirdy
  class WexceptionsControllerTest < ActionController::TestCase
    setup { @routes = Weirdy::Engine.routes }

    test "should get exceptions list with correct http basic auth" do
      create_wexception(RuntimeError, "Something is wrong")
      Weirdy::Config.auth = "admin/123"
      http_basic_auth_login("admin", "123")
      get :index
      assert_response :success
      assert_select "p.kind", "RuntimeError"
    end

    test "should not get exceptions list with incorrect http basic auth" do
      Weirdy::Config.auth = "admin/123"
      http_basic_auth_login("admin", "1234")
      get :index
      assert_response 401
    end

    test "should get exceptions list when auth proc returns true" do
      create_wexception(RuntimeError, "Something is wrong")
      Weirdy::Config.auth = lambda { |controller| true }
      get :index
      assert_response :success
      assert_select "p.kind", "RuntimeError"
    end

    test "should not get exceptions list when auth proc returns false" do
      create_wexception(RuntimeError, "Something is wrong")
      Weirdy::Config.auth = lambda { |controller| false }
      get :index
      assert_response :success
      assert_empty response.body # nothing is rendered
    end

    test "should show closed exceptions on correct parameter" do
      wexception = create_wexception(RuntimeError, "Something is wrong")
      Weirdy::Config.auth = lambda { |controller| true }

      get :index, params: { 'state' => 'closed' }
      assert_response :success
      assert_select "td", /There are no \w+ exceptions/

      wexception.change_state(:closed)

      get :index, params: { 'state' => 'closed' }
      assert_response :success
      assert_select "p.kind", "RuntimeError"
    end

    test "can order by occurrences" do
      create_wexception(RuntimeError, "Something is wrong")
      Weirdy::Config.auth = lambda { |controller| true }
      get :index, params: { 'order' => 'occurrences' }
      assert_response :success
    end

    test "should change state" do
      wexception = create_wexception(RuntimeError, "Something is wrong")
      Weirdy::Config.auth = lambda { |controller| true }
      assert wexception.state?(:opened)
      put :state, params: { 'id' => wexception.id, 'state' => 'closed' }, xhr: true
      wexception.reload
      assert_response :success
      assert wexception.state?(:closed)
    end

    test "should destroy wexception" do
      wexception = create_wexception(RuntimeError, "Something is wrong")
      Weirdy::Config.auth = lambda { |controller| true }
      delete :destroy, params: { 'id' => wexception.id }, xhr: true
      assert_response :success
      assert_nil Wexception.where(id: wexception.id).first
    end

    test "should handle exceptions with null backtrace" do
      create_wexception(RuntimeError, "Something is wrong", nil)
      create_wexception(RuntimeError, "Something is wrong", nil)
      Weirdy::Config.auth = "admin/123"
      http_basic_auth_login("admin", "123")
      get :index
      assert_response :success
    end

    test "should not break if not exists exception when changing state" do
      Weirdy::Config.auth = lambda { |controller| true }
      put :state, params: { 'id' => 911, 'state' => 'closed' }, xhr: true
      assert_response :success
    end

    test "should not break if not exists when deleting" do
      Weirdy::Config.auth = lambda { |controller| true }
      delete :destroy, params: { 'id' => 911 }, xhr: true
      assert_response :success
    end
  end
end
