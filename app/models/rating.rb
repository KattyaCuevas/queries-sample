class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :ratingable, polymorphic: true
end

# == Schema Information
#
# Table name: ratings
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  value           :integer
#  ratingable_type :string           not null
#  ratingable_id   :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_ratings_on_ratingable_type_and_ratingable_id  (ratingable_type,ratingable_id)
#  index_ratings_on_user_id                            (user_id)
#
