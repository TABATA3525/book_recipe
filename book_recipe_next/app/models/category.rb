class Category < ApplicationRecord
    has_many :user_categories, dependent: :destroy
    has_many :user_books, through: :user_categories
end
