require 'rails_helper'

describe 'LinkPosts' do
  describe 'creating link posts' do
    context 'not logged in' do
      it 'redirects new post to login' do
        user = create(:user)
        get new_user_link_post_path(user)
        assert_redirected_to login_url
      end

      it 'does not allow creation' do
        user = create(:user)
        assert_no_difference 'LinkPost.count' do
          post user_link_posts_path(user),
               params: {
                 link_post: { link_text: 'Link text',
                              link: 'example.com',
                              content: 'Text about this link' }
               }
        end
        assert_redirected_to login_url
      end
    end

    context 'logged in with different user' do
      it 'redirects new post to root' do
        user = create(:user)
        other_user = create(:user)
        log_in_as(user)
        get new_user_link_post_path(other_user)
        assert_redirected_to root_url
      end

      it 'does not allow creation' do
        user = create(:user)
        other_user = create(:user)
        log_in_as(user)
        assert_no_difference 'LinkPost.count' do
          post user_link_posts_path(other_user),
               params: {
                 link_post: { link_text: 'Link text',
                              link: 'example.com',
                              content: 'Text about this link' }
               }
        end
        assert_redirected_to root_url
      end
    end

    context 'logged in with correct user' do
      it 'gets new post page' do
        user = create(:user)
        log_in_as(user)
        get new_user_link_post_path(user)
      end

      context 'using valid data' do
        it 'creates new post' do
          user = create(:user)
          post = build(:link_post)
          log_in_as(user)
          assert_difference 'LinkPost.count', 1 do
            post user_link_posts_path(user),
                 params: {
                   link_post: { link_text: post.link_text,
                                link: post.link,
                                content: post.content }
                 }
          end
          follow_redirect!
        end
      end

      context 'with invalid data' do
        it 'does not allow creation' do
          user = create(:user)
          log_in_as(user)
          assert_no_difference 'LinkPost.count' do
            post user_link_posts_path(user),
                 params: {
                   link_post: { link_text: '',
                                link: 'example.com',
                                content: 'Text about this link' }
                 }
          end
          assert_no_difference 'LinkPost.count' do
            post user_link_posts_path(user),
                 params: {
                   link_post: { link_text: 'Link Text',
                                link: 'example.com',
                                content: '' }
                 }
          end
          assert_no_difference 'LinkPost.count' do
            post user_link_posts_path(user),
                 params: {
                   link_post: { link_text: 'Link Text',
                                link: '',
                                content: 'Text about this link' }
                 }
          end
        end
      end
    end
  end
end
