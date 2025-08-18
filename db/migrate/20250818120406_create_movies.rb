class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.integer :hashed_id
      t.string :title
      t.integer :category

      t.timestamps
    end
  end
end
