class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :link_post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bookmarks, %i[user_id link_post_id], unique: true
  end
end
