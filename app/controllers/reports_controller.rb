class ReportsController < ActionController::API
  def index
    total = params[:total]&.to_i || 5
    songs_query = SongQuery.new(total)
    render json: {
      only_songs: songs_query.only_songs_info,
      with_artists: songs_query.with_artist_info,
      with_albums: songs_query.with_album_info,
      with_artists_and_albums: songs_query.with_artists_and_albums_info
    }
  end

  def only_songs
    total = params[:total]&.to_i || 5
    render json: SongQuery.new(total).only_songs_info
  end

  def with_artists
    total = params[:total]&.to_i || 5
    render json: SongQuery.new(total).with_artist_info
  end

  def with_albums
    total = params[:total]&.to_i || 5
    render json: SongQuery.new(total).with_album_info
  end

  def with_artists_and_albums
    total = params[:total]&.to_i || 5
    render json: SongQuery.new(total).with_artists_and_albums_info
  end

  def views_index
    total = params[:total]&.to_i || 5
    songs = SongsRating.first(total)
    render json: {
      only_songs: songs.as_json(only: [:title, :rating]),
      with_artists: songs.as_json(only: [:title, :rating, :artists_name]),
      with_albums: songs.as_json(only: [:title, :rating, :album_title]),
      with_artists_and_albums: songs.as_json(only: [:title, :rating, :artists_name, :album_title])
    }
  end

  def views_only_songs
    total = params[:total]&.to_i || 5
    render json: SongsRating.first(total).as_json(only: [:title, :rating])
  end

  def views_with_artists
    total = params[:total]&.to_i || 5
    render json: SongsRating.first(total).as_json(only: [:title, :rating, :artists_name])
  end

  def views_with_albums
    total = params[:total]&.to_i || 5
    render json: SongsRating.first(total).as_json(only: [:title, :rating, :album_title])
  end

  def views_with_artists_and_albums
    total = params[:total]&.to_i || 5
    render json: SongsRating.first(total).as_json(only: [:title, :rating, :artists_name, :album_title])
  end
end
