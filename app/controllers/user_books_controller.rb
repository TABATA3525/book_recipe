class UserBooksController < ApplicationController
  require 'open-uri'
  require 'uri'
  before_action :authenticate_user!
  
  def new
  end
  
  def create
    @userBook = UserBook.new(user_book_params)
    @userBook[:user_id] = current_user.id
    user_book_image_parsed = URI.parse(user_book_params[:user_book_image])
    if user_book_image_parsed.path != "/user_books/new"
    # 画像があった場合
      f = open user_book_params[:user_book_image]
      @userBook.user_book_image.attach io: f, filename: File.basename(f)
    else
    # 画像がなかった場合
      @userBook.user_book_image = nil
    end
    @userBook.save
  end
  
  def user_book_params
    params.permit(:title, :author, :user_book_image)
  end
end
