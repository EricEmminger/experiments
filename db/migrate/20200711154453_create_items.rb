class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :guid
      t.string :external_url
      t.string :title
      t.string :summary
      t.datetime :updated
      t.datetime :published
      t.text :content_html
      t.text :content_text
      t.text :authors
      t.text :tags
      t.text :attachments

      t.timestamps
    end
    add_index :items, :guid, unique: true
  end
end
