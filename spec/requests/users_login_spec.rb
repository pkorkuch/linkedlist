describe 'Users login' do
  context 'login with invalid credentials' do
    it 'does not log in when email and password are invalid' do
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

    it 'does not log in when email is valid and password is invalid' do
      user = create(:user)
      get login_path
      assert_select 'input[type="email"]', count: 1
      assert_select 'input[type="password"]', count: 1
      post login_path, params: { session: { email: user.email, password: 'wrong_password' } }
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

  context 'login with valid credentials' do
    it 'logs in and logs out correctly' do
      user = create(:user, :activated)
      get login_path
      post login_path, params: { session: { email: user.email,
                                            password: 'password' } }
      assert_redirected_to user
      follow_redirect!
      assert_select 'h2, h3, h4', user.name
      assert_select 'a[href=?]', login_path, count: 0
      assert_select 'a[href=?]', logout_path
      assert_select 'a[href=?]', user_path(user)
      delete logout_path
      assert_not is_logged_in?
      assert_redirected_to root_url
      # Try logging out again
      delete logout_path
      assert_redirected_to root_url
    end
  end

  context 'login with remembering' do
    it 'sets remember token cookie' do
      user = create(:user, :activated)
      log_in_as user, remember_me: '1'
      expect(cookies[:remember_token]).not_to be_empty
    end
  end

  context 'login without remembering' do
    it 'unsets remember token cookie' do
      user = create(:user, :activated)

      # Log in once to set the cookie
      log_in_as user, remember_me: '1'
      expect(cookies[:remember_token]).not_to be_empty

      # Log in again and verify the cookie is deleted
      log_in_as user, remember_me: '0'
      assert_empty cookies[:remember_token]
    end
  end
end
