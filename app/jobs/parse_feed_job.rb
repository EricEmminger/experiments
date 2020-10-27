# frozen_string_literal: true

require 'open-uri'
require 'feedparser'

# Parse a URL into a feed and its items
class ParseFeedJob < ApplicationJob
  queue_as :default

  def perform(feed)
    return if feed.url.starts_with?('/')

    parsed = FeedParser::Parser.parse(URI(feed.url).open.read)
    # update_attributes(feed, parsed)
    feed.ingest_feed(parsed)
    # update_profile(feed)
    # feed.initialize_profile
    feed.save!
    # feed.profile.save!
    # subscription = Subscription.find_or_initialize_by(profile_id: feed.profile.id, feed_id: feed.id)
    # subscription.save!
    # parsed.items.each do |parsed_item|
    #   item = Item.find_or_initialize_by(guid: parsed_item.guid)
    #   item.feeds << feed unless item.feeds.include?(feed)
    #   # item.external_url = parsed_item.external_url
    #   # item.title = parsed_item.title
    #   # item.summary = parsed_item.summary
    #   # item.updated = parsed_item.updated
    #   # item.published = parsed_item.published
    #   # item.content_html = parsed_item.content_html
    #   # item.content_text = parsed_item.content_text
    #   item.authors = parsed_item.authors.to_json
    #   item.tags = parsed_item.tags.to_json
    #   # item.attachments = parsed_item.attachments
    #   keys = %i[external_url title summary updated published content_html content_text attachments]
    #   item.attributes = JSON.parse(parsed_item.to_json).slice(*keys)
    #   item.profile = feed.profile
    #   item.save!
    # end
  end

  # def update_attributes(feed, parsed)
  #   feed.format = parsed.format
  #   feed.title = parsed.title
  #   feed.summary = parsed.summary
  #   feed.generator = parsed.generator
  #   feed.updated = parsed.updated
  #   feed.published = parsed.published
  #   # keys = %i[format title summary generator updated published]
  #   # feed.attributes = JSON.parse(parsed.to_json).slice(*keys)
  #   feed.authors = parsed.authors.to_json
  #   feed.tags = parsed.tags.to_json
  # end

  # def update_profile(feed)
  #   return unless feed.profile.nil?

  #   profile = Profile.find_or_initialize_by(url: feed.url)
  #   # profile.user = user
  #   profile.user_id = 1 if profile.user_id.nil?
  #   profile.name = feed.title if profile.name.nil?
  #   profile.save!
  #   feed.profile = profile
  # end
end
