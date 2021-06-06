class UserBooksController < ApplicationController
  require 'open-uri'
  before_action :authenticate_user!
  
  def new
  end
  
  def create
    @userBook = UserBook.new(user_book_params)
    begin
      f = open user_book_params[:user_book_image]
      @userBook.user_book_image.attach io: f, filename: File.basename(f)
    rescue => e
      logger.error e
    end
    
    @userBook[:user_id] = current_user.id
    @userBook.save
    
  end
  
  
  def user_book_params
    params.permit(:title, :author, :user_book_image)
  end
end
