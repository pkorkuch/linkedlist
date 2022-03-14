describe 'Users profile' do
  it 'should list all link posts from that user' do
    user = create(:user)
    posts = create_list(:link_post, 5, user: user)

    get user_path(user)
    assert_select 'article', minimum: 5
    posts.each do |post|
      assert_select 'article h2, h3, h4', post.link_text
      assert_select 'article a[href=?]', post.link
      assert_select 'article p', post.content
    end
  end
end
