class ItemResource < ApplicationResource
  has_many :syndications
  many_to_many :feeds
  has_many :reactions

  attribute :guid, :string
  attribute :external_url, :string
  attribute :title, :string
  attribute :summary, :string
  attribute :updated, :datetime
  attribute :published, :datetime
  attribute :content, :string
  attribute :content_plain, :string
  attribute :content_safe, :string
  attribute :content_html, :string
  attribute :content_text, :string
  attribute :authors, :string
  attribute :tags, :string
  attribute :attachments, :string

  filter :profile_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(feeds: :subscriptions).distinct.where(feeds: {subscriptions: {profile_id: value}}).where.not(published: nil)
    end
  end

  def base_scope
    Item.order(published: :desc, id: :asc)
  end
end
