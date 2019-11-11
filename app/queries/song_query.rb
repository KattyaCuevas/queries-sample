class SongQuery
  def initialize(total)
    @total = total
  end

  def only_songs_info
    ratings = Rating.where(ratingable_type: 'Song')
      .group(:ratingable_id).average(:value)
      .sort { |a, b| b[1] <=> a[1] }.take(@total).to_h
    Song.find(ratings.keys).each_with_object({}) do |song, hash|
      hash[song.id] = { song: song.title, rating_avg: ratings[song.id] }
    end
  end

  def with_artist_info
    ratings = Rating.where(ratingable_type: 'Song')
      .group(:ratingable_id).average(:value)
      .sort { |a, b| b[1] <=> a[1] }.take(@total).to_h
    Song.includes(:artist).find(ratings.keys)
      .each_with_object({}) do |song, hash|
        hash[song.id] = { song: song.title, artist: song.artist.name,
          rating_avg: ratings[song.id] }
      end
  end

  def with_album_info
    ratings = Rating.where(ratingable_type: 'Song')
      .group(:ratingable_id).average(:value)
      .sort { |a, b| b[1] <=> a[1] }.take(@total).to_h
    Song.includes(:album).find(ratings.keys)
      .each_with_object({}) do |song, hash|
        hash[song.id] = { song: song.title, album: song.album.title,
          rating_avg: ratings[song.id] }
      end
  end

  def with_artists_and_albums_info
    ratings = Rating.where(ratingable_type: 'Song')
      .group(:ratingable_id).average(:value)
      .sort { |a, b| b[1] <=> a[1] }.take(@total).to_h
    Song.includes(:album, :artist).find(ratings.keys)
      .each_with_object({}) do |song, hash|
        hash[song.id] = { song: song.title, artist: song.artist.name,
          album: song.album.title, rating_avg: ratings[song.id] }
      end
  end
end
