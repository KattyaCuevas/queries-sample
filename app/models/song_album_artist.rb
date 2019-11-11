class SongAlbumArtist < ApplicationRecord
  belongs_to :song
  belongs_to :album
  belongs_to :artist
end

# == Schema Information
#
# Table name: song_album_artists
#
#  id         :integer          not null, primary key
#  song_id    :integer          not null
#  album_id   :integer          not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_song_album_artists_on_album_id   (album_id)
#  index_song_album_artists_on_artist_id  (artist_id)
#  index_song_album_artists_on_song_id    (song_id)
#
