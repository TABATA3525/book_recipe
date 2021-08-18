class CategoriesController < ApplicationController
  def index
    @defaultCategories = Category.where(user_id: nil)
    @categories = Category.where(user_id: current_user.id).order(:user_id, :id)
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find_or_initialize_by(
      id: categories_params[:category_id],
      user_id: current_user.id,
      )
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
    @category = Category.find(params[:id])
    if  @category.user_id == current_user.id
      @category.destroy
      redirect_to categories_index_url
    end
  end
  
  private
  def categories_params
    params.permit(:category_name, :category_id)
  end
end
