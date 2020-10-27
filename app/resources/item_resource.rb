# frozen_string_literal: true

# ItemResource
class ItemResource < ApplicationResource
  attribute :attachments, :string
  attribute :authors, :string
  attribute :content_html, :string
  attribute :content_plain, :string, writable: false
  attribute :content_safe, :string, writable: false
  attribute :content_text, :string
  attribute :content, :string, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :external_url, :string
  attribute :guid, :string
  attribute :profile_id, :integer, only: [:filterable]
  attribute :published, :datetime, allow_nil: true
  attribute :summary, :string
  attribute :tags, :string
  attribute :title, :string
  attribute :updated_at, :datetime, writable: false
  attribute :updated, :datetime
  belongs_to :profile
  has_many :reactions
  has_many :syndications
  many_to_many :feeds

  filter :subscription_id, :integer do
    eq do |scope, value|
      scope.joins(feeds: :subscriptions).distinct
           .where(feeds: { subscriptions: { profile_id: value } })
           .where.not(published: nil).where.not(profile_id: nil)
    end
  end

  filter :draft, :boolean do
    eq do |scope, value|
      if value
        scope.where(published: nil)
      else
        scope.where.not(published: nil)
      end
    end
  end

  def base_scope
    Item.order(published: :desc, id: :asc)
  end
end
