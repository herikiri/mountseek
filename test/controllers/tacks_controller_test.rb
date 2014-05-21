require 'test_helper'

class TacksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
