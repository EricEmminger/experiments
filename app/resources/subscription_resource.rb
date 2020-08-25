class SubscriptionResource < ApplicationResource
  belongs_to :profile
  belongs_to :feed

  attribute :profile_id, :integer
  attribute :feed_id, :integer
  attribute :notify, :boolean
  attribute :mute, :boolean
end
