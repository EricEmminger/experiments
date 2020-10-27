# frozen_string_literal: true

# SubscriptionResource
class SubscriptionResource < ApplicationResource
  attribute :created_at, :datetime, writable: false
  attribute :feed_id, :integer, only: [:filterable]
  attribute :mute, :boolean
  attribute :notify, :boolean
  attribute :profile_id, :integer, only: [:filterable]
  attribute :updated_at, :datetime, writable: false
  belongs_to :feed
  belongs_to :profile
end
