class AddUserIdToFeelingCategories < ActiveRecord::Migration[5.2]
  def change
    # 基本形: user_idという名前で users.id への外部キー制約をはる
    add_reference :feeling_categories, :user, foreign_key: true
  end
end