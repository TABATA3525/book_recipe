class Api::V1::FeelingCategoriesController < ApplicationController
    def index
        feelingCategories = FeelingCategory.where(user_id: current_user.id).or(FeelingCategory.where(user_id: nil)).order(:user_id, :id) 
        render json: feelingCategories
    end
end