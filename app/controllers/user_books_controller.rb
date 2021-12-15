class UserBooksController < ApplicationController
  require 'open-uri'
  require 'uri'
  before_action :authenticate_user!
  before_action :set_user_book, only: [:edit, :show, :destroy, :update]
  
  def index
    @userBooks = UserBook.where(user_id: current_user.id).order(id: 'DESC')
    @feeling_category_ids = []
    @stars = []
  end
  
  def search
    @userBooks = UserBook.search(params[:keyword],params[:category_ids],params[:feeling_category_ids],params[:stars], current_user)
    @keyword = params[:keyword]
    @category_ids = params[:category_ids]
    @feeling_category_ids = params[:feeling_category_ids] ||= []
    @stars = params[:stars] ||= []
    render "index"
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
    if @userBook.save
      # 登録したら、カテゴリーと読後感の初期設定を『未登録』カテゴリーにしたい。
      @userCategory = UserCategory.new(category_id: 1, user_book_id: @userBook.id)
      @userCategory.save!
      @userFeelingCategory = UserFeelingCategory.new(feeling_category_id: 1, user_book_id: @userBook.id)
      @userFeelingCategory.save!
      # vueで正常処理をするために記述
      render status: 200, json: {status: 200, message: "Success" }
    else
      # vueでエラー処理をするために記述
      render status: 500, json: {status: 500, message: "同じタイトルの本は登録できません" }
    end
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
    if user_book_update_params[:feeling_category_id].present?
      @userBook.user_feeling_categories.destroy_all
      user_book_update_params[:feeling_category_id].each_with_index do |feeling_category_id, index|
        next if feeling_category_id.blank?
        @userFeelingCategory = UserFeelingCategory.new(
          user_book_id: @userBook.id
        )
      
        @userFeelingCategory.feeling_category_id = feeling_category_id
        @userFeelingCategory.stars = user_book_update_params[:user_feeling_category_star][index]
        @userFeelingCategory.save!
      end
    end

    # 読後感のカテゴリーを追加する機能。読後感追加するページは別に作ったので、今後必要なければ、消します。
    # if user_book_update_params[:feeling_after_reading].present?
    #   @feelingCategory = FeelingCategory.find_or_initialize_by(
    #     user_id: current_user.id,
    #     feeling_after_reading: user_book_update_params[:feeling_after_reading]
    #   )
    #   @feelingCategory.save!
    # end

    redirect_to user_books_url
  end
  
  def destroy
    @userBook.destroy
    redirect_to user_books_url
  end
  
  private
  def user_book_params
    params.permit(:title, :author, :user_book_image)
  end
  
  def user_book_update_params
    params.require(:user_book).permit(:title, :author, :feeling_category, :feeling, 
                                      :category_ids, :feeling_after_reading, :feeling_category_ids,
                                      user_feeling_category_star: [], feeling_category_id: []
                                     )
  end
    
  def set_user_book
    @userBook = UserBook.find(params[:id]) 
  end
  
end
