class SyndicationResource < ApplicationResource
  belongs_to :feed
  belongs_to :item
  has_many :subscriptions

  attribute :feed_id, :integer
  attribute :item_id, :integer
  attribute :shared, :boolean
end
