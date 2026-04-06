require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @category = Category.create!(category_name: 'My Category', user: @user)
    @other_category = Category.create!(category_name: 'Other Category', user: @other_user)
  end

  test 'redirects guests from index' do
    get categories_index_url

    assert_redirected_to new_user_session_path
  end

  test 'returns not found when editing another users category' do
    sign_in @user

    get category_edit_url(@other_category)

    assert_response :not_found
  end

  test 'returns not found when deleting another users category' do
    sign_in @user

    assert_no_difference('Category.count') do
      delete category_destroy_url(@other_category)
    end

    assert_response :not_found
  end
end
