class Artist < ApplicationRecord
  has_many :song_album_artist
  has_many :songs, through: :song_album_artist
  has_many :albums, through: :song_album_artist
end

# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
