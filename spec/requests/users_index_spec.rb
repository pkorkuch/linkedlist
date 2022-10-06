describe 'Users index' do
  it 'lists users with pagination' do
    user = create(:user, :activated)
    31.times do
      create(:user, :activated)
    end
    log_in_as user
    get users_path
    assert_select 'h2, h3, h4', 'Users'
    assert_select 'article', count: 30
    assert_select 'a[href=?]', users_path(page: 2), count: 1
    get users_path(page: 2)
    assert_select 'h2, h3, h4', 'Users'
    assert_select 'article', count: 2
  end
end
