class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :ratingable, polymorphic: true
end
