class SongAlbumArtist < ApplicationRecord
  belongs_to :song
  belongs_to :album
  belongs_to :artist
end
