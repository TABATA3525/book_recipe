require 'test_helper'

class UserBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_books_new_url
    assert_response :success
  end

end
