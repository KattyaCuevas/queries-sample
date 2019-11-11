class Album < ApplicationRecord
  has_many :ratings, as: :ratingable
  has_many :song_album_artist
  has_many :songs, through: :song_album_artist
  has_many :artists, through: :song_album_artist
end

# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
