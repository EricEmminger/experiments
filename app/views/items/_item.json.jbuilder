json.extract! item, :id, :guid, :external_url, :title, :summary, :updated, :published, :content_html, :content_text, :authors, :tags, :attachments, :created_at, :updated_at
json.url item_url(item, format: :json)
