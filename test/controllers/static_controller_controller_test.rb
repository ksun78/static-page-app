require 'test_helper'

class StaticControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_controller_home_url
    assert_response :success
  end

  test "should get help" do
    get static_controller_help_url
    assert_response :success
  end

end
