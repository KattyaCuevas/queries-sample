require "benchmark"
require_relative "./app/models"

def get_first_songs_include(n)
  Song.includes(:ratings)
    .map do |song|
      ratings = song.ratings.pluck(:value)
      rating_avg = ratings.sum / ratings.count.to_f
      { song: song.title, rating_avg: rating_avg }
    end
    .sort { |a, b| b[:rating_avg] <=> a[:rating_avg] }
    .take(n)
end

Benchmark.bm do |x|
  x.report { get_first_songs_include(5) }
  x.report { get_first_songs_include(10) }
  x.report { get_first_songs_include(50) }
  x.report { get_first_songs_include(100) }
end

# user     system      total        real
# 11.522454   0.344063  11.866517 ( 12.547735)
# 11.649318   0.519888  12.169206 ( 12.652715)
# 11.247852   0.108175  11.356027 ( 11.882358)
# 10.462803   0.082460  10.545263 ( 11.054610)

def get_first_songs_active_record(n)
  ratings = Rating.where(ratingable_type: "Song")
    .group(:ratingable_id).average(:value)
    .sort { |a, b| b[1] <=> a[1] }.take(n)
  ratings.map do |rating|
    { song: Song.find(rating[0]).title, rating_avg: rating[1].to_f }
  end
end

Benchmark.bm do |x|
  x.report { get_first_songs_active_record(5) }
  x.report { get_first_songs_active_record(10) }
  x.report { get_first_songs_active_record(50) }
  x.report { get_first_songs_active_record(100) }
end

# user     system      total        real
# 0.050067   0.001880   0.051947 (  0.122572)
# 0.045683   0.001381   0.047064 (  0.115590)
# 0.052397   0.002717   0.055114 (  0.133475)
# 0.139835   0.006092   0.145927 (  0.245305)



def get_first_songs_artists_include(n)
  Song.includes(:ratings, :artist)
    .map do |song|
      ratings = song.ratings.pluck(:value)
      rating_avg = ratings.sum / ratings.count.to_f
      { song: song.title, artists: song.artist.name, rating_avg: rating_avg }
    end
    .sort { |a, b| b[:rating_avg] <=> a[:rating_avg] }
    .take(5)
end

Benchmark.bm do |x|
  x.report { get_first_songs_artists_include(5) }
  x.report { get_first_songs_artists_include(10) }
  x.report { get_first_songs_artists_include(50) }
  x.report { get_first_songs_artists_include(100) }
end

# user     system      total        real
# 12.089685   0.169765  12.259450 ( 13.028933)
# 11.813765   0.167311  11.981076 ( 12.723309)
# 12.239966   0.370570  12.610536 ( 13.403950)
# 11.755766   0.106952  11.862718 ( 12.625627)

def get_first_songs_artist_active_record(n)
  ratings = Rating.where(ratingable_type: "Song")
    .group(:ratingable_id).average(:value)
    .sort { |a, b| b[1] <=> a[1] }.take(n)
  ratings.map do |rating|
    song = Song.find(rating[0])
    { song: song.title, artist: song.artist.name,
      rating_avg: rating[1].to_f }
  end
end

Benchmark.bm do |x|
  x.report { get_first_songs_artist_active_record(5) }
  x.report { get_first_songs_artist_active_record(10) }
  x.report { get_first_songs_artist_active_record(50) }
  x.report { get_first_songs_artist_active_record(100) }
end

# user     system      total        real
# 0.069387   0.002005   0.071392 (  0.141608)
# 0.086728   0.002548   0.089276 (  0.161589)
# 0.417373   0.007609   0.424982 (  0.563877)
# 0.150733   0.011625   0.162358 (  0.418567)

def get_first_songs_artist_active_record_includes(n)
  ratings = Rating.where(ratingable_type: "Song")
    .group(:ratingable_id).average(:value)
    .sort { |a, b| b[1] <=> a[1] }.take(n).to_h
  songs = Song.includes(:artist).find(ratings.keys)
  ratings.map do |rating|
    song = songs.detect { |song| song.id == rating[0] }
    { song: song.title, artist: song.artist.name,
      rating_avg: rating[1].to_f }
  end
end

Benchmark.bm do |x|
  x.report { get_first_songs_artist_active_record_includes(5) }
  x.report { get_first_songs_artist_active_record_includes(10) }
  x.report { get_first_songs_artist_active_record_includes(50) }
  x.report { get_first_songs_artist_active_record_includes(100) }
end

# user     system      total        real
# 0.052463   0.001593   0.054056 (  0.129918)
# 0.043838   0.001215   0.045053 (  0.113101)
# 0.115463   0.001132   0.116595 (  0.193957)
# 0.057161   0.001080   0.058241 (  0.135369)