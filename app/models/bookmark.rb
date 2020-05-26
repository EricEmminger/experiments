class Bookmark < ApplicationRecord
  belongs_to :user
  validates :name, :url, presence: true
  validates :url, uniqueness: {scope: :user_id, case_sensitive: false}
end
