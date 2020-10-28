# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Register default user
email = 'EricEmminger@gmail.com'
name = 'Eric Emminger'
user = User.find_or_initialize_by(id: 1, email: email.downcase)
user.save!

if user.profiles.empty?
  a_url = "/users/#{user.id}/profiles"
  profile = Profile.find_or_initialize_by(url: a_url)
  profile.user = user
  profile.name = name
  profile.save!
  profile.url = "/profiles/#{profile.id}/items"
  profile.save!
end

urls = []
urls << user.profiles[0].url
urls << 'https://www.ruby-lang.org/en/feeds/news.rss'
urls << 'https://weblog.rubyonrails.org/feed/atom.xml'
urls << 'https://jsonfeed.org/feed.json'
urls.each do |url|
  feed = Feed.find_or_initialize_by(url: url)
  feed.save!
end

# item = Item.first
# reaction = Reaction.new(profile_id: user.profiles[0].id, item_id: item.id)
# reaction.kind = 'open'
# reaction.save!
