class FeelingCategoriesController < ApplicationController
  def index
    @defaultFeelingCategories = FeelingCategory.where(user_id: nil)
    @feelingCategories = FeelingCategory.where(user_id: current_user.id).order(:user_id, :id)
  end
  
  def edit
    @feelingCategory = FeelingCategory.find(params[:id])
  end
  
  def update
    if feeling_category_params[:feeling_after_reading].present?
      @feelingCategory = FeelingCategory.find_or_initialize_by(
        id: feeling_category[:feeling_category_id],
        user_id: current_user.id
      )
      @feelingCategory.feeling_after_reading = feeling_category_params[:feeling_after_reading]
      @feelingCategory.save!
    end
    redirect_to feeling_categories_edit_url
  end
  
  def create
    @feelingCategory = FeelingCategory.find_or_initialize_by(
      user_id: current_user.id,
      feeling_after_reading: feeling_category_params[:feeling_after_reading]
    )
    @feelingCategory.save!
    redirect_to feeling_categories_index_url
  end
  
  def destroy
    @feelingCategory = FeelingCategory.find_by(
      id: params[:id], 
      user_id: current_user.id
    )
    @feelingCategory.destroy
    redirect_to feeling_categories_index_url
  end
  
  private
  def feeling_category_params
    params.permit(:feeling_after_reading, :feeling_category_id)
  end
end
