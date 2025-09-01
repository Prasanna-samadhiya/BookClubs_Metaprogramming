require "test_helper"

class BookclubControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bookclub_index_url
    assert_response :success
  end
end
