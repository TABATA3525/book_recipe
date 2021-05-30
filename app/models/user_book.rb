class UserBook < ApplicationRecord
  belongs_to :user
  has_one_attached :user_book_image
end
