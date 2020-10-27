# frozen_string_literal: true

# Feed
class Feed < ApplicationRecord
  # class_attribute :base_url, instance_writer: false, default: 'http://api.spa.test/'
  # Feed.base_url = 'http://api.spa.test/'

  after_create_commit do
    ParseFeedJob.perform_later(self) unless url.starts_with?('/')
  end
  belongs_to :profile, optional: true
  has_many :syndications
  has_many :items, through: :syndications
  has_many :subscriptions
  validates :url, uniqueness: true, url: { no_local: true, public_suffix: true, schemes: %w[http https] }

  def ingest_feed(parsed)
    # keys = %i[format title summary generator updated published]
    # assign_attributes(JSON.parse(parsed.to_json).slice(*keys))
    self.format = parsed.format
    self.title = parsed.title
    self.summary = parsed.summary
    self.generator = parsed.generator
    self.updated = parsed.updated
    self.published = parsed.published
    self.authors = parsed.authors.to_json
    self.tags = parsed.tags.to_json
    initialize_profile
    # save!
    ingest_items(parsed.items)
  end

  def ingest_items(parsed_items)
    parsed_items.each do |parsed_item|
      item = Item.find_or_initialize_by(guid: parsed_item.url)
      # keys = %i[external_url title summary updated published content_html content_text attachments]
      # item.assign_attributes(JSON.parse(parsed_item.to_json).slice(*keys))
      item.ingest_item(parsed_item)
      item.profile = profile if item.profile.nil?
      item.save!
      # feeds << feed unless feeds.include?(feed)
      items << item unless items.include?(item)
    end
  end

  # def initialize
  #   @base_url = 'http://api.spa.test/'
  #   super
  # end

  def initialize_profile
    self.profile = Profile.find_or_initialize_by(url: url) if profile.nil?
    # self.profile.user = user
    profile.user_id = 1 if profile.user_id.nil?
    profile.name = title if profile.name.nil?
    profile.save!
    subscription = Subscription.find_or_initialize_by(profile_id: profile.id, feed_id: id)
    subscription.save!
  end
end
