# frozen_string_literal: true

# Profile
class Profile < ApplicationRecord
  belongs_to :user
  has_many :feeds
  has_many :items
  has_many :reactions
  has_many :subscriptions
  # alias_attribute :label, :name
  # alias_attribute :value, :id
  # def label
  #   "#{name} (#{url})"
  # end
end
