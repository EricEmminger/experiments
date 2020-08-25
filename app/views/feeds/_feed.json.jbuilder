json.extract! feed, :id, :url, :format, :title, :summary, :generator, :updated, :published, :authors, :tags, :created_at, :updated_at
json.url feed_url(feed, format: :json)
