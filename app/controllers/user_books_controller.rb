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
    if @userBook.update(
        title: user_book_update_params[:title],
        author: user_book_update_params[:author],
        feeling: user_book_update_params[:feeling]
      )
      redirect_to user_books_url
    else
      render :edit
    end
  end
  
  def destroy
    @userBook.destroy
    redirect_to user_books_url
  end
  
  def user_book_params
    params.permit(:title, :author, :user_book_image)
  end
  
  def user_book_update_params
    params.require(:user_book).permit(:title, :author, :feeling_category, :feeling)
    params.require(:category).permit(:category_name)
  end
  
  def set_user_book
    @userBook = UserBook.find(params[:id]) 
  end
  
end
