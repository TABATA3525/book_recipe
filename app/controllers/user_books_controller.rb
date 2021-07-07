class UserBooksController < ApplicationController
  require 'open-uri'
  require 'uri'
  before_action :authenticate_user!
  before_action :set_user_book, only: [:edit, :show, :destroy, :update]
  
  def index
    @userBooks = UserBook.all
  end
  
  def new
  end
  
  def create
    @userBook = UserBook.new(
      title: user_book_params[:title],
      author: user_book_params[:author],
      user_id: current_user.id
    )
    user_book_image_parsed = URI.parse(user_book_params[:user_book_image])
    if user_book_image_parsed.path != "/user_books/new"
    # 画像があった場合
      f = open user_book_params[:user_book_image]
      @userBook.user_book_image.attach io: f, filename: File.basename(f)
    end
    @userBook.save
  end
  
  def edit
  end

  def update
    @userBook.update!(
      title: user_book_update_params[:title],
      author: user_book_update_params[:author],
      feeling: user_book_update_params[:feeling]
    )
    if user_book_update_params[:category_ids].present?
      @userCategory = UserCategory.find_or_initialize_by(
        user_book_id: @userBook.id
      )
      @userCategory.category_id = user_book_update_params[:category_ids]
      @userCategory.save!
    end
    
    if user_book_update_params[:felling_category_ids].present?
      @userFeelingCategory = UserFeelingCategory.find_or_initialize_by(
        user_book_id: @userBook.id
      )
    
      @userFeelingCategory.feeling_category_id = user_book_update_params[:feeling_category_ids]
      @userFeelingCategory.stars = user_book_update_params[:user_feeling_category_stars]
      @userFeelingCategory.save!
    end
    
    if user_book_update_params[:feeling_after_reading].present?
      @feelingCategory = FeelingCategory.find_or_initialize_by(
        user_id: current_user.id,
        feeling_after_reading: user_book_update_params[:feeling_after_reading]
      )
      @feelingCategory.save!
    end
    redirect_to user_books_url
  end
  
  def destroy
    @userBook.destroy
    redirect_to user_books_url
  end
  
  def user_book_params
    params.permit(:title, :author, :user_book_image)
  end
  
  def user_book_update_params
    params.require(:user_book).permit(:title, :author, :feeling_category, :feeling, 
                                      :category_ids, :feeling_category_ids,:user_feeling_category_stars,
                                      :feeling_after_reading
                                     )
  end
    
  def set_user_book
    @userBook = UserBook.find(params[:id]) 
  end
  
end
