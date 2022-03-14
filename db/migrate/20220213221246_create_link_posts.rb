class CreateLinkPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :link_posts do |t|
      t.string :link_text
      t.text :content
      t.text :link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :link_posts, %i[user_id created_at]
  end
end
