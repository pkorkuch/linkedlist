require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:existing_user)
  end

  test 'login with invalid email and password' do
    get login_path
    assert_select 'input[type="email"]', count: 1
    assert_select 'input[type="password"]', count: 1
    post login_path, params: { session: { email: '', password: '' } }
    assert_select 'input[type="email"]', count: 1
    assert_select 'input[type="password"]', count: 1
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 1
    assert_not flash.empty?
    get root_path
    assert_select 'div[role="alert"]', count: 0
    assert flash.empty?
  end

  test 'login with valid credentials followed by logout' do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_select 'h2, h3, h4', @user.name
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

  test 'login with valid email and invalid password' do
    get login_path
    assert_select 'input[type="email"]', count: 1
    assert_select 'input[type="password"]', count: 1
    post login_path, params: { session: { email: @user.email, password: 'wrong_password' } }
    assert_select 'input[type="email"]', count: 1
    assert_select 'input[type="password"]', count: 1
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 1
    assert_not flash.empty?
    get root_path
    assert_select 'div[role="alert"]', count: 0
    assert flash.empty?
  end
end
