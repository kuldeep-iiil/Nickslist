require 'test_helper'

class SearchCustomerControllerTest < ActionController::TestCase
  test "should get Get_Details" do
    get :Get_Details
    assert_response :success
  end

end
