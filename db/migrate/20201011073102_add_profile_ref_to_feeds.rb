class AddProfileRefToFeeds < ActiveRecord::Migration[6.0]
  def change
    add_reference :feeds, :profile, null: true, foreign_key: true
  end
end
