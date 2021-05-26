class UserBooksController < ApplicationController
  before_action :authenticate_user!
  
  def new
  end
  
  def create
    @userBook = UserBook.new(user_book_params)
    @userBook[:user_id] = current_user.id
    @userBook.save
  end
  
  
  def user_book_params
    params.permit(:title, :author)
  end
end
