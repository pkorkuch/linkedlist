require 'rails_helper'

describe 'Bookmarks' do
  context 'not logged in' do
    it 'does not create a new bookmark' do
      link_post = create(:link_post)

      assert_no_difference 'Bookmark.count' do
        post bookmarks_path, params: { post_id: link_post.id }
      end
    end

    it 'does not delete an existing bookmark' do
      bookmark = create(:bookmark)

      assert_no_difference 'Bookmark.count' do
        delete bookmark_path(bookmark)
      end
    end
  end

  context 'logged in' do
    it 'creates a new bookmark for the current user' do
      user = create(:user, :activated)
      link_post = create(:link_post)
      log_in_as user

      assert_difference 'Bookmark.count', 1 do
        post bookmarks_path, params: { post_id: link_post.id }
      end
      expect(user.bookmarks.count).to eq(1)
      expect(user.bookmarked_link_posts.include?(link_post)).to be true
    end

    it 'deletes an existing bookmark' do
      bookmark = create(:bookmark)
      user = bookmark.user
      log_in_as user

      assert_difference 'Bookmark.count', -1 do
        delete bookmark_path(bookmark)
      end
      expect(user.bookmarks.count).to eq(0)
      expect(user.bookmarked_link_posts.include?(bookmark.link_post)).to be false
    end

    it 'does not create a bookmark to a non-existent post' do
      user = create(:user)
      log_in_as user

      # Use build to generate a valid id that does not exist in the database
      bad_post_id = build(:link_post).id

      assert_no_difference 'Bookmark.count' do
        post bookmarks_path, params: { post_id: bad_post_id }
      end
    end

    it 'does not create a duplicate of an existing bookmark' do
      bookmark = create(:bookmark)
      log_in_as bookmark.user

      assert_no_difference 'Bookmark.count' do
        post bookmarks_path, params: { post_id: bookmark.link_post.id }
      end
    end

    it 'does not delete an existing bookmark from another user' do
      bookmark = create(:bookmark)
      user = bookmark.user
      other_user = create(:user)
      log_in_as other_user

      assert_no_difference 'Bookmark.count' do
        delete bookmark_path(bookmark)
      end
      expect(user.bookmarks.count).to eq(1)
      expect(user.bookmarked_link_posts.include?(bookmark.link_post)).to be true
    end
  end
end
