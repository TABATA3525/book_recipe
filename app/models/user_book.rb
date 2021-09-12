class UserBook < ApplicationRecord
  belongs_to :user
  has_one_attached :user_book_image
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :user_feeling_categories, dependent: :destroy
  has_many :feeling_categories, through: :user_feeling_categories
  
  def self.search(keyword, category_ids, feeling_category_ids, stars, feeling_category_ids2, stars2)
    # 後日、見直した！スッキリ！
    query = self.order(id: 'DESC')
    query = query.where(["(title like ? OR author like ?)", "%#{keyword}%", "%#{keyword}%"]) if keyword.present?
    query = query.left_joins(:categories).where(["categories.id = ?", category_ids]) if category_ids.present?
    if feeling_category_ids.present?
      query1 = query.left_joins(:feeling_categories).where(["feeling_categories.id = ?", feeling_category_ids]) 
      if stars == "stars_5"
        sign = "="
        stars = 5
      end
      if stars == "stars_4"
        sign = "="
        stars = 4
      end
      if stars == "stars_3"
        sign = "="
        stars = 3
      end
      if stars == "stars_2"
        sign = "="
        stars = 2
      end
      if stars == "stars_1"
        sign = "="
        stars = 1
      end
      if stars == "stars_high"
        sign = ">="
        stars = 3
      end
      if stars == "stars_low"
        sign = "<="
        stars = 2
      end
      query1 = query1.where(["user_feeling_categories.stars = ?", stars]) if sign == "="
      query1 = query1.where(["user_feeling_categories.stars >= ?", stars]) if sign == ">="
      query1 = query1.where(["user_feeling_categories.stars <= ?", stars]) if sign == "<="
    end
    user_book_ids1 = query1.pluck(:id) if feeling_category_ids.present?
    if feeling_category_ids2.present?
      query2 = query.left_joins(:feeling_categories).where(["feeling_categories.id = ?", feeling_category_ids2]) 
      if stars == "stars_5"
        sign = "="
        stars = 5
      end
      if stars2 == "stars_4"
        sign = "="
        stars = 4
      end
      if stars2 == "stars_3"
        sign = "="
        stars = 3
      end
      if stars2 == "stars_2"
        sign = "="
        stars = 2
      end
      if stars2 == "stars_1"
        sign = "="
        stars = 1
      end
      if stars2 == "stars_high"
        sign = ">="
        stars = 3
      end
      if stars2 == "stars_low"
        sign = "<="
        stars = 2
      end
      query2 = query2.where(["user_feeling_categories.stars = ?", stars]) if sign == "="
      query2 = query2.where(["user_feeling_categories.stars >= ?", stars]) if sign == ">="
      query2 = query2.where(["user_feeling_categories.stars <= ?", stars]) if sign == "<="
    end
    user_book_ids2 = query2.pluck(:id) if feeling_category_ids2.present?
    user_book_ids = user_book_ids1 & user_book_ids2
    query = query.where(id: user_book_ids) if feeling_category_ids.present?
    return query
  end
end
