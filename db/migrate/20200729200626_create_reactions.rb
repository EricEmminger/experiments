class CreateReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :reactions do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :kind

      t.timestamps
    end
  end
end
