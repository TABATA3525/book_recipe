class UserBook < ApplicationRecord
  belongs_to :user
  has_one_attached :user_book_image
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :user_feeling_categories, dependent: :destroy
  has_many :feeling_categories, through: :user_feeling_categories
  
  def self.search(keyword, category_ids, feeling_category_ids)
    # 後日、見直した！スッキリ！
    query = self.order(id: 'DESC')
    query = query.where(["(title like ? OR author like ?)", "%#{keyword}%", "%#{keyword}%"]) if keyword.present?
    query = query.left_joins(:categories).where(["categories.id = ?", category_ids]) if category_ids.present?
    query = query.left_joins(:feeling_categories).where(["feeling_categories.id = ?", feeling_category_ids]) if feeling_category_ids.present?
    return query
  end
end
