class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :feed, null: false, foreign_key: true
      t.boolean :notify
      t.boolean :mute

      t.timestamps
    end
    add_index :subscriptions, [:profile_id, :feed_id], unique: true
end
end
