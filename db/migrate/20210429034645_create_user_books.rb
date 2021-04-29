class CreateUserBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :author
      t.text :feeling

      t.timestamps
    end
  end
end
