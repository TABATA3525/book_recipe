class UserFeelingCategory < ApplicationRecord
  belongs_to :user_book
  belongs_to :feeling_category
end
