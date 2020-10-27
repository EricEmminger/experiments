class AddProfileRefToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :profile, null: true, foreign_key: true
  end
end
