require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'user is not created when signup info is invalid' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_select 'form', count: 1
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 4
  end

  test 'user is created when signup info is valid' do
    new_user = { name: 'First Last',
                 email: 'test@example.com',
                 password: 'password',
                 password_confirmation: 'password' }
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: new_user }
    end
    follow_redirect!
    assert_select 'h2, h3', new_user[:name]
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 1
    assert_not flash.empty?
    assert is_logged_in?
  end
end
