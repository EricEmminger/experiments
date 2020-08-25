class ProfileResource < ApplicationResource
  belongs_to :user
  has_many :subscriptions
  has_many :reactions

  attribute :user_id, :integer
  attribute :url, :string
  attribute :name, :string
  attribute :private, :boolean
end
