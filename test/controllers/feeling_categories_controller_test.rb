require 'test_helper'

class FeelingCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @feeling_category = FeelingCategory.create!(feeling_after_reading: 'Calm', user: @user)
    @other_feeling_category = FeelingCategory.create!(feeling_after_reading: 'Other Feeling', user: @other_user)
  end

  test 'redirects guests from index' do
    get feeling_categories_index_url

    assert_redirected_to new_user_session_path
  end

  test 'returns not found when editing another users feeling category' do
    sign_in @user

    get feeling_category_edit_url(@other_feeling_category)

    assert_response :not_found
  end

  test 'returns not found when deleting another users feeling category' do
    sign_in @user

    assert_no_difference('FeelingCategory.count') do
      delete feeling_categories_destroy_url(@other_feeling_category)
    end

    assert_response :not_found
  end
end
