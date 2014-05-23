require 'test_helper'

class PlaceControllerTest < ActionController::TestCase
  test "should get horse" do
    get :horse
    assert_response :success
  end

  test "should get stud" do
    get :stud
    assert_response :success
  end

  test "should get trailer" do
    get :trailer
    assert_response :success
  end

  test "should get tack" do
    get :tack
    assert_response :success
  end

  test "should get real_estate" do
    get :real_estate
    assert_response :success
  end

  test "should get service" do
    get :service
    assert_response :success
  end

end
