class CreateUserFeelingCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_feeling_categories do |t|
      t.references :user_book, null: false, foreign_key: true
      t.integer :feeling_category_id
      t.integer :stars

      t.timestamps
    end
  end
end
