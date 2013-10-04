require 'test_helper'

class CustomerSearchControllerTest < ActionController::TestCase
  test "should get GetDetails" do
    get :GetDetails
    assert_response :success
  end

end
