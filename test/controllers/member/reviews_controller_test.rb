require "test_helper"

class Member::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_reviews_index_url
    assert_response :success
  end
end
