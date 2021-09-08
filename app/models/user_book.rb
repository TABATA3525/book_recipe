class UserBook < ApplicationRecord
  belongs_to :user
  has_one_attached :user_book_image
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :user_feeling_categories, dependent: :destroy
  has_many :feeling_categories, through: :user_feeling_categories
  
  def self.search(keyword, category_ids, feeling_category_ids, stars)
    # 後日、見直した！スッキリ！
    query = self.order(id: 'DESC')
    query = query.where(["(title like ? OR author like ?)", "%#{keyword}%", "%#{keyword}%"]) if keyword.present?
    query = query.left_joins(:categories).where(["categories.id = ?", category_ids]) if category_ids.present?
    if feeling_category_ids.present?
      query = query.left_joins(:feeling_categories).where(["feeling_categories.id = ?", feeling_category_ids]) 
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
      query = query.where(["user_feeling_categories.stars = ?", stars]) if sign == "="
      query = query.where(["user_feeling_categories.stars >= ?", stars]) if sign == ">="
      query = query.where(["user_feeling_categories.stars <= ?", stars]) if sign == "<="
    end
    return query
  end
end
