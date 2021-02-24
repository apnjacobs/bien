class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :review, uniqueness: { scope: :user }
end
