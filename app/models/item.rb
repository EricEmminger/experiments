class Item < ApplicationRecord
  has_many :syndications
  has_many :feeds, through: :syndications
  has_many :reactions

  def content
    content_html || content_text || summary
  end

  def content_plain
    ActionView::Base.full_sanitizer.sanitize(content)
  end

  def content_safe
    safe_list_sanitizer = Rails::Html::SafeListSanitizer.new
    safe_list_sanitizer.sanitize(content, tags: %w(h2 h3 li ul p), attributes: %w(id class style))
  end
end
