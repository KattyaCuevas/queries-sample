class Song < ApplicationRecord
  has_many :ratings, as: :ratingable
  has_one :song_album_artist
  has_one :album, through: :song_album_artist
  has_one :artist, through: :song_album_artist
end

# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  title      :string
#  duration   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
