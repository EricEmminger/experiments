class FeedResource < ApplicationResource
  has_many :syndications
  many_to_many :items
  has_many :subscriptions
  
  attribute :url, :string
  attribute :format, :string
  attribute :title, :string
  attribute :summary, :string
  attribute :generator, :string
  attribute :updated, :datetime
  attribute :published, :datetime
  attribute :authors, :string
  attribute :tags, :string
end
