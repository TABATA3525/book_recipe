class UserBook < ApplicationRecord
  belongs_to :user
  has_one_attached :user_book_image
  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :user_feeling_categories
  has_many :feeling_categories, through: :user_feeling_categories
  
  def self.search(keyword)
    left_joins(:categories).where(["title like ? OR author like ? OR categories.category_name like ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
end
