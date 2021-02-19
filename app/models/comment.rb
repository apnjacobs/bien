class Comment < ApplicationRecord
  require 'obscenity/active_model'
  belongs_to :review

  validates :body, presence: true
  validates :body, obscenity: { sanitize: true, replacement: "[censored]" }

end
