require 'rails_helper'

describe 'New post creation' do
  context 'not logged in' do
    it 'does not show new post button' do
      visit root_path
      expect(page).to_not have_link 'New Post', exact: false
    end
  end

  context 'logged in' do
    it 'shows new post button' do
      user = create(:user, :activated)
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log In'
      expect(page).to have_content user.name
      visit root_path
      expect(page).to have_link 'New Post'
    end

    it 'allows new posts to be created' do
      user = create(:user, :activated)
      post = build(:link_post)
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log In'
      expect(page).to have_content user.name
      visit root_path
      click_link 'New Post'
      fill_in 'Title', with: post.link_text
      fill_in 'Body', with: post.content
      fill_in 'Link', with: post.link
      click_button 'Create Post'
      expect(page).to have_content(post.content)
      expect(page).to have_link(post.link_text, href: post.link)
      visit user_path(user)
      expect(page).to have_content(post.content)
      expect(page).to have_link(post.link_text, href: post.link)
      click_link 'Log Out'
      expect(page).to have_current_path(login_path)
      visit user_path(user)
      expect(page).to have_content(post.content)
      expect(page).to have_link(post.link_text, href: post.link)
    end
  end
end
