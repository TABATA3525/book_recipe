class FeelingCategory < ApplicationRecord
    has_many :user_feeling_categories
    has_many :user_books, through: :user_feeling_categories
    validates :feeling_after_reading, presence: true
end
