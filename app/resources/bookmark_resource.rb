# frozen_string_literal: true

# BookmarkResource
class BookmarkResource < ApplicationResource
  attribute :created_at, :datetime, writable: false
  attribute :name, :string
  attribute :updated_at, :datetime, writable: false
  attribute :url, :string

  def base_scope
    Bookmark.where(user_id: current_user)
  end
end
