# frozen_string_literal: true

# ProfileResource
class ProfileResource < ApplicationResource
  attribute :created_at, :datetime, writable: false
  # attribute :label, :string, only: [:readable]
  attribute :name, :string
  attribute :private, :boolean
  attribute :updated_at, :datetime, writable: false
  attribute :url, :string
  attribute :user_id, :integer, only: [:filterable]
  # attribute :value, :integer, only: [:readable]
  belongs_to :user
  has_many :feeds
  has_many :items
  has_many :reactions
  has_many :subscriptions

  def base_scope
    Profile.where(user_id: current_user)
  end
end
