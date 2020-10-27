# frozen_string_literal: true

# Item
class Item < ApplicationRecord
  belongs_to :profile
  has_many :syndications
  has_many :feeds, through: :syndications
  has_many :reactions
  validates :guid, uniqueness: true, url: { no_local: true, public_suffix: true, schemes: %w[http https] }

  def content
    content_html || content_text || summary
  end

  def content_plain
    ActionView::Base.full_sanitizer.sanitize(content)
  end

  def content_safe
    safe_list_sanitizer = Rails::Html::SafeListSanitizer.new
    safe_list_sanitizer.sanitize(content, tags: %w[h2 h3 li ul p], attributes: %w[id class style])
  end

  def ingest_item(parsed_item)
    self.external_url = parsed_item.external_url
    # self.external_url = parsed_item.guid if external_url.nil?
    self.title = parsed_item.title
    self.summary = parsed_item.summary
    self.updated = parsed_item.updated
    self.published = parsed_item.published
    self.content_html = parsed_item.content_html
    self.content_text = parsed_item.content_text
    self.authors = parsed_item.authors.to_json
    self.tags = parsed_item.tags.to_json
    self.attachments = parsed_item.attachments.to_json
    # self.profile = feed.profile if profile.nil?
    # save!
    # feeds << feed unless feeds.include?(feed)
    # items << item unless items.include?(item)
  end
end
