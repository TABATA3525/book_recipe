class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :destroy]

  def index
    @defaultCategories = Category.where(user_id: nil)
    @categories = Category.where(user_id: current_user.id).order(:user_id, :id)
  end
  
  def new
  end

  def edit
  end
  
  def update
    @category = Category.find_by!(id: categories_params[:category_id], user_id: current_user.id)
    @category.category_name = categories_params[:category_name]
    @category.save!
    redirect_to categories_index_url
  end
  
  def create
    @category = Category.find_or_initialize_by(
      user_id: current_user.id,
      category_name: categories_params[:category_name]
      )
    @category.save!
    redirect_to categories_index_url
  end
  
  def destroy
    @category.destroy
    redirect_to categories_index_url
  end
  
  private

  def set_category
    @category = Category.find_by!(id: params[:id], user_id: current_user.id)
  end

  def categories_params
    params.permit(:category_name, :category_id)
  end
end
