class CreateSongsRatings < ActiveRecord::Migration[6.0]
  def change
    create_view :songs_ratings, materialized: true
  end
end
