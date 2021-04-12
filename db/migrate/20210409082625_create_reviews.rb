class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.string :user_name
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
