require 'test_helper'

class RealEstatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
