class CreateSyndications < ActiveRecord::Migration[6.0]
  def change
    create_table :syndications do |t|
      t.references :feed, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.boolean :shared

      t.timestamps
    end
    add_index :syndications, [:feed_id, :item_id], unique: true
  end
end
