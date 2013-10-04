require 'test_helper'

class ReviewCustomerControllerTest < ActionController::TestCase
  test "should get Add_Details" do
    get :Add_Details
    assert_response :success
  end

end
