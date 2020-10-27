# frozen_string_literal: true

# FeedResource
class FeedResource < ApplicationResource
  attribute :authors, :string
  attribute :created_at, :datetime, writable: false
  attribute :format, :string
  attribute :generator, :string
  attribute :profile_id, :integer, only: [:filterable]
  attribute :published, :datetime
  attribute :summary, :string
  attribute :tags, :string
  attribute :title, :string
  attribute :updated_at, :datetime, writable: false
  attribute :updated, :datetime
  attribute :url, :string
  belongs_to :profile # , writable: false
  has_many :subscriptions
  has_many :syndications
  many_to_many :items
end
