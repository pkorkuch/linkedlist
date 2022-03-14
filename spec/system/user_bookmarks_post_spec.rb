require 'rails_helper'

describe 'Post bookmarking' do
  context 'not logged in' do
    it 'does not show bookmark button' do
      user = create(:user)
      post = user.link_posts.create(attributes_for(:link_post))
      visit user_path(user)
      expect(page).to have_content(post.content)
      expect(page).to have_link(post.link_text, href: post.link)
      expect(page).to_not have_button('Bookmark post')
    end
  end

  context 'logged in' do
    it 'shows bookmark button' do
      user = create(:user)
      active_user = create(:user)
      post = user.link_posts.create(attributes_for(:link_post))
      log_in_with active_user
      visit user_path(user)
      expect(page).to have_content(post.content)
      expect(page).to have_link(post.link_text, href: post.link)
      expect(page).to have_button('Bookmark post')
    end

    it 'creates a new bookmark' do
      user = create(:user)
      active_user = create(:user)
      post = user.link_posts.create(attributes_for(:link_post))
      log_in_with active_user
      visit user_path(user)
      page.find('article article', text: post.content).click_button('Bookmark post')
      visit user_bookmarks_path(active_user)
      expect(page).to have_content(post.link_text)
    end
  end
end
