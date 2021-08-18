class FeelingCategoriesController < ApplicationController
  def edit
    @feelingCategories = FeelingCategory.where(user_id: current_user.id).or(FeelingCategory.where(user_id: nil)).order(:user_id, :id)
  end
  
  def update
    if category_params[:feeling_after_reading].present?
      @feelingCategory = FeelingCategory.find_or_initialize_by(
        user_id: current_user.id,
        feeling_after_reading: user_book_update_params[:feeling_after_reading]
      )
      @feelingCategory.save!
    end
    redirect_to categories_edit_url
  end
end
