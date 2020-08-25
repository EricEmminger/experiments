class Profile < ApplicationRecord
  belongs_to :user
  has_many :subscriptions
  has_many :reactions
end
