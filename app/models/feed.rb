class Feed < ApplicationRecord
  has_many :syndications
  has_many :items, through: :syndications
  has_many :subscriptions
end
