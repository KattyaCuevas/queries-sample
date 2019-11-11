# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_08_181214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "value"
    t.string "ratingable_type", null: false
    t.bigint "ratingable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ratingable_type", "ratingable_id"], name: "index_ratings_on_ratingable_type_and_ratingable_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "song_album_artists", force: :cascade do |t|
    t.bigint "song_id", null: false
    t.bigint "album_id", null: false
    t.bigint "artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id"], name: "index_song_album_artists_on_album_id"
    t.index ["artist_id"], name: "index_song_album_artists_on_artist_id"
    t.index ["song_id"], name: "index_song_album_artists_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "ratings", "users"
  add_foreign_key "song_album_artists", "albums"
  add_foreign_key "song_album_artists", "artists"
  add_foreign_key "song_album_artists", "songs"

  create_view "songs_ratings", materialized: true, sql_definition: <<-SQL
      SELECT songs_ratings.id,
      songs_ratings.title,
      (songs_ratings.rating)::double precision AS rating,
      albums.id AS album_id,
      albums.title AS album_title,
      artists.id AS artist_id,
      artists.name AS artists_name
     FROM (((( SELECT songs.id,
              songs.title,
              avg(ratings.value) AS rating
             FROM (ratings
               JOIN songs ON ((ratings.ratingable_id = songs.id)))
            WHERE ((ratings.ratingable_type)::text = 'Song'::text)
            GROUP BY ratings.ratingable_id, songs.id) songs_ratings
       JOIN song_album_artists ON ((song_album_artists.song_id = songs_ratings.id)))
       JOIN albums ON ((song_album_artists.album_id = albums.id)))
       JOIN artists ON ((song_album_artists.artist_id = artists.id)));
  SQL
end
