class UserBook < ApplicationRecord
  belongs_to :user
  has_one_attached :user_book_image
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :user_feeling_categories, dependent: :destroy
  has_many :feeling_categories, through: :user_feeling_categories

  def self.search(keyword, category_ids, feeling_category_ids, stars, current_user)
    query = self.order(id: 'DESC')
    query = query.where(["(title like ? OR author like ?)", "%#{keyword}%", "%#{keyword}%"]) if keyword.present?
    query = query.left_joins(:categories).where(["categories.id = ?", category_ids]) if category_ids.present?
    user_book_ids = UserBook.where(user_id: current_user.id).pluck(:id)
    if feeling_category_ids&.first.present?
      feeling_category_ids.each_with_index do |feeling_category_id, index|
        feeling_category_query = query.left_joins(:feeling_categories).where(["feeling_categories.id = ?", feeling_category_id]) 
        if stars[index] == "stars_5"
          sign = "="
          search_stars = 5
        end
        if stars[index] == "stars_4"
          sign = "="
          search_stars = 4
        end
        if stars[index] == "stars_3"
          sign = "="
          search_stars = 3
        end
        if stars[index] == "stars_2"
          sign = "="
          search_stars = 2
        end
        if stars[index] == "stars_1"
          sign = "="
          search_stars = 1
        end
        if stars[index] == "stars_high"
          sign = ">="
          search_stars = 3
        end
        if stars[index] == "stars_low"
          sign = "<="
          search_stars = 2
        end
        feeling_category_query = feeling_category_query.where(["user_feeling_categories.stars = ?", search_stars]) if sign == "="
        feeling_category_query = feeling_category_query.where(["user_feeling_categories.stars >= ?", search_stars]) if sign == ">="
        feeling_category_query = feeling_category_query.where(["user_feeling_categories.stars <= ?", search_stars]) if sign == "<="
        user_book_ids = user_book_ids & feeling_category_query.pluck(:id)
      end
    end
    query = query.where(id: user_book_ids)
    return query
  end
end
