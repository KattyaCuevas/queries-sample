Rails.application.routes.draw do
  root to: 'reports#index'

  resources :reports, only: :index do
    get :only_songs, on: :collection
    get :with_artists, on: :collection
    get :with_albums, on: :collection
    get :with_artists_and_albums, on: :collection
    scope 'views', on: :collection do
      root to: 'reports#views_index'
      get :only_songs, on: :collection, to: 'reports#views_only_songs'
      get :with_artists, on: :collection, to: 'reports#views_with_artists'
      get :with_albums, on: :collection, to: 'reports#views_with_albums'
      get :with_artists_and_albums, on: :collection, to: 'reports#views_with_artists_and_albums'
    end
  end
end

# localhost:3000/reports/only_songs
# localhost:3000/reports/with_artists
# localhost:3000/reports/with_albums
# localhost:3000/reports/with_artists_and_albums
# localhost:3000/reports

# localhost:3000/views/reports/only_songs
# localhost:3000/views/reports/with_artists
# localhost:3000/views/reports/with_albums
# localhost:3000/views/reports/with_artists_and_albums
# localhost:3000/views/reports

# localhost:3000/reports/only_songs?total=1000
# localhost:3000/reports/with_artists?total=1000
# localhost:3000/reports/with_albums?total=1000
# localhost:3000/reports/with_artists_and_albums?total=1000
# localhost:3000/reports?total=1000

# localhost:3000/views/reports/only_songs?total=1000
# localhost:3000/views/reports/with_artists?total=1000
# localhost:3000/views/reports/with_albums?total=1000
# localhost:3000/views/reports/with_artists_and_albums?total=1000
# localhost:3000/views/reports?total=1000
