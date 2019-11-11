1_500.times { User.create(name: Faker::FunnyName.name_with_initial) }

150.times do
  artist = Artist.create(
    name: Faker::Artist.name,
    age: (12..80).to_a.sample
  )

  (0..4).to_a.sample.times do
    album = Album.create(title: Faker::Music.album)
    (0..20).to_a.sample.times do
      user = User.order('RANDOM()').first
      album.ratings << Rating.create(user: user, value: (1..5).to_a.sample)
    end
    user = User.order('RANDOM()').first
    (2..10).to_a.sample.times do
      song = Song.create(
        title: "Faker::Music::#{%w[GratefulDead Phish UmphreysMcgee].sample}".constantize.song,
        duration: (120..500).to_a.sample
      )

      SongAlbumArtist.create(song: song, album: album, artist: artist)
      (0..30).to_a.sample.times do
        user = User.order('RANDOM()').first
        song.ratings << Rating.create(user: user, value: (1..5).to_a.sample)
      end
    end
  end
end
