require 'test_helper'

class UserBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)

    @user_book = UserBook.create!(
      user: @user,
      title: 'Owned Book',
      author: 'Owner Author'
    )
    @other_user_book = UserBook.create!(
      user: @other_user,
      title: 'Other Book',
      author: 'Other Author'
    )

    @shared_category = Category.create!(category_name: 'Shared Category')
    @user_category = Category.create!(category_name: 'My Category', user: @user)
    @other_user_category = Category.create!(category_name: 'Other Category', user: @other_user)
  end

  test 'redirects guests from index' do
    get user_books_url

    assert_redirected_to new_user_session_path
  end

  test 'returns not found when editing another users book' do
    sign_in @user

    get edit_user_book_url(@other_user_book)

    assert_response :not_found
  end

  test 'returns not found when deleting another users book' do
    sign_in @user

    assert_no_difference('UserBook.count') do
      delete user_book_url(@other_user_book)
    end

    assert_response :not_found
  end

  test 'edit page shows only shared and owned categories' do
    sign_in @user

    get edit_user_book_url(@user_book)

    assert_response :success
    assert_match 'Shared Category', response.body
    assert_match 'My Category', response.body
    assert_no_match 'Other Category', response.body
  end

  test 'search page shows only shared and owned categories' do
    sign_in @user

    get search_url

    assert_response :success
    assert_match 'Shared Category', response.body
    assert_match 'My Category', response.body
    assert_no_match 'Other Category', response.body
  end
end
