class BookmarkResource < ApplicationResource
  attribute :name, :string
  attribute :url, :string

  def base_scope
    Bookmark.where(user_id: current_user)
  end
end
