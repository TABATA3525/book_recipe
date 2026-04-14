class CreateFeelingCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :feeling_categories do |t|
      t.string :feeling_after_reading

      t.timestamps
    end
  end
end
