class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :url, null: false
      t.string :tags, array: true

      t.timestamps
    end
    add_index :bookmarks, :tags, using: 'gin'
  end
end
