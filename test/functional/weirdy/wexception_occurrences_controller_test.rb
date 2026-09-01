require 'test_helper'

module Weirdy
  class WexceptionOccurrencesControllerTest < ActionController::TestCase
    setup { @routes = Weirdy::Engine.routes }

    test "should get wexception occurrences for a wexception" do
      wexception = create_wexception(RuntimeError, "Something is wrong")
      Weirdy::Config.auth = lambda { |controller| true }
      get :index, params: { wexception_id: wexception.id }, xhr: true
      assert_response :success
      assert_not_nil assigns(:wexception_occurrences)
      assert @response.body.include?(wexception.occurrences.first.message)
    end
  end
end
