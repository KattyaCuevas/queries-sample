SELECT
	songs_ratings.id AS id,
	songs_ratings.title AS title,
	songs_ratings.rating::float AS rating,
	albums.id AS album_id,
	albums.title AS album_title,
	artists.id AS artist_id,
	artists.name AS artists_name
FROM(
	SELECT
		songs.id AS id,
		songs.title AS title,
		AVG(ratings.value) AS rating
	FROM ratings
	JOIN
		songs ON ratings.ratingable_id = songs.id
	WHERE ratings.ratingable_type = 'Song'
	GROUP BY (ratings.ratingable_id, songs.id)
) AS songs_ratings
JOIN
	song_album_artists ON song_album_artists.song_id = songs_ratings.id
JOIN
	albums ON song_album_artists.album_id = albums.id
JOIN
	artists ON song_album_artists.artist_id = artists.id
