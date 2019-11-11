class SongsRating < ApplicationRecord
  self.primary_key = :id

  belongs_to :album
  belongs_to :artist

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
end

# == Schema Information
#
# Table name: songs_ratings
#
#  id           :integer          primary key
#  title        :string
#  rating       :float
#  album_id     :integer
#  album_title  :string
#  artist_id    :integer
#  artists_name :string
#
