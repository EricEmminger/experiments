require 'open-uri'
require 'feedparser'

class ParseFeedJob < ApplicationJob
  queue_as :default

  def perform(feed)
    parsed = FeedParser::Parser.parse( URI(feed.url).open.read )
    feed.format = parsed.format
    feed.title = parsed.title
    feed.summary = parsed.summary
    feed.generator = parsed.generator
    feed.updated = parsed.updated
    feed.published = parsed.published
    feed.authors = parsed.authors.to_json
    feed.tags = parsed.tags
    feed.save
    parsed.items.each do |parsed_item|
      item = Item.find_or_initialize_by(guid: parsed_item.guid)
      item.feeds << feed unless item.feeds.include?(feed)
      item.external_url = parsed_item.external_url
      item.title = parsed_item.title
      item.summary = parsed_item.summary
      item.updated = parsed_item.updated
      item.published = parsed_item.published
      item.content_html = parsed_item.content_html
      item.content_text = parsed_item.content_text
      item.authors = parsed_item.authors.to_json
      item.tags = parsed_item.tags.to_json
      item.attachments = parsed_item.attachments
      item.save
    end
  end
end
