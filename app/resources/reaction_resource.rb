# frozen_string_literal: true

# ReactionResource
class ReactionResource < ApplicationResource
  attribute :created_at, :datetime, writable: false
  attribute :item_id, :integer, only: [:filterable]
  attribute :kind, :string
  attribute :profile_id, :integer, only: [:filterable]
  attribute :updated_at, :datetime, writable: false
  belongs_to :item
  belongs_to :profile
end
