class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url
      t.string :name
      t.boolean :private

      t.timestamps
    end
    add_index :profiles, :url, unique: true
  end
end
