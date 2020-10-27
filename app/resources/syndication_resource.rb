# frozen_string_literal: true

# SyndicationResource
class SyndicationResource < ApplicationResource
  attribute :created_at, :datetime, writable: false
  attribute :feed_id, :integer, only: [:filterable]
  attribute :item_id, :integer, only: [:filterable]
  attribute :shared, :boolean
  attribute :updated_at, :datetime, writable: false
  belongs_to :feed
  belongs_to :item
  has_many :subscriptions
end
