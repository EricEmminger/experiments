class Syndication < ApplicationRecord
  belongs_to :feed
  belongs_to :item
  has_many :subscriptions
end
