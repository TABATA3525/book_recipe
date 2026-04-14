class UserCategory < ApplicationRecord
  belongs_to :user_book
  belongs_to :category
end
