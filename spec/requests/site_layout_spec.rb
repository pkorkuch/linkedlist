describe 'Site layout' do
  it 'shows all layout links' do
    user = create(:user)
    get root_path
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', signup_path
    assert_select 'a[href=?]', login_path
    log_in_as user
    follow_redirect!
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', signup_path
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', user_path(user)
    assert_select 'a[href=?]', edit_user_path(user)
    assert_select 'a[href=?]', logout_path
  end
end
