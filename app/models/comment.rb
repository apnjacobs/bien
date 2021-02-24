class Comment < ApplicationRecord
  require 'obscenity/active_model'

  belongs_to :review
  belongs_to :user

  validates :body, presence: true
  validates :body, obscenity: { sanitize: true, replacement: "[censored]" }

end
