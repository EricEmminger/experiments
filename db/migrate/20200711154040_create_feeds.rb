class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :format
      t.string :title
      t.string :summary
      t.string :generator
      t.datetime :updated
      t.datetime :published
      t.text :authors
      t.text :tags

      t.timestamps
    end
    add_index :feeds, :url, unique: true
  end
end
