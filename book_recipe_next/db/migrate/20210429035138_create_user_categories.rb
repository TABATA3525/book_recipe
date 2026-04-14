class CreateUserCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_categories do |t|
      t.references :user_book, null: false, foreign_key: true
      t.integer :category_id

      t.timestamps
    end
  end
end
