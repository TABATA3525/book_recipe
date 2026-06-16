class Category < ApplicationRecord
  has_many :user_categories, dependent: :destroy
  has_many :user_books, through: :user_categories
  validates :category_name, presence: true
  validates :category_name, uniqueness: { scope: :user_id }
end
