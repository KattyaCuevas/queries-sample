class Song < ApplicationRecord
  has_many :ratings, as: :ratingable
end
