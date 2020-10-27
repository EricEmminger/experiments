# frozen_string_literal: true

# Subscription
class Subscription < ApplicationRecord
  belongs_to :feed
  belongs_to :profile
end
