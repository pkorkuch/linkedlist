describe 'Users editing' do
  context 'edit with invalid values' do
    it 'does not modify user' do
      user = create(:user, :activated)
      log_in_as user
      get edit_user_path(user)
      assert_select 'form', count: 1
      assert_select 'input[value=?]', user.name
      assert_select 'input[value=?]', user.email
      assert_select 'input[type="password"]', count: 2
      patch user_path(user), params: { user: { name: '',
                                               email: 'invalid',
                                               password: 'foo',
                                               password_confirm: 'bar' } }
      assert_select 'div[role="alert"]', count: 1
      assert_select 'form', count: 1
      assert_select 'input[type="password"]', count: 2
    end
  end

  context 'edit with valid values' do
    it 'modifies user' do
      user = create(:user, :activated)
      log_in_as user
      get edit_user_path(user)
      assert_select 'form', count: 1
      assert_select 'input[value=?]', user.name
      assert_select 'input[value=?]', user.email
      assert_select 'input[type="password"]', count: 2
      patch user_path(user), params: { user: { name: 'New Name',
                                               email: 'new@example.com',
                                               password: 'newpassword',
                                               password_confirm: 'newpassword' } }
      assert_redirected_to user_path(user)
      follow_redirect!
      user.reload
      assert_equal 'New Name', user.name
      assert_equal 'new@example.com', user.email
      assert_not user.authenticate('password')
      assert user.authenticate('newpassword')
      assert_select 'h2, h3, h4', user.name
      assert_not flash.empty?
      assert_select 'div[role="alert"]', count: 1
    end
  end

  context 'friendly forwarding' do
    it 'forwards after login to user edit page' do
      user = create(:user, :activated)
      get edit_user_path(user)
      log_in_as user
      assert_redirected_to edit_user_path(user)
      follow_redirect!
      assert_select 'form', count: 1
      assert_select 'input[value=?]', user.name
      assert_select 'input[value=?]', user.email
      assert_select 'input[type="password"]', count: 2
      patch user_path(user), params: { user: { name: 'New Name',
                                               email: 'new@example.com',
                                               password: 'newpassword',
                                               password_confirm: 'newpassword' } }
      assert_redirected_to user_path(user)
      follow_redirect!
      user.reload
      assert_equal 'New Name', user.name
      assert_equal 'new@example.com', user.email
      assert_not user.authenticate('password')
      assert user.authenticate('newpassword')
      assert_select 'h2, h3, h4', user.name
      assert_not flash.empty?
      assert_select 'div[role="alert"]', count: 1
    end

    it 'only forwards once' do
      user = create(:user, :activated)

      # Try to edit user, log in, and then log in again
      get edit_user_path(user)
      log_in_as user
      assert_redirected_to edit_user_path(user)
      follow_redirect!
      log_in_as user
      assert_redirected_to user_path(user)

      # Log out, try to edit user, log in, log out, and log in again
      delete logout_path
      follow_redirect!
      get edit_user_path(user)
      log_in_as user
      assert_redirected_to edit_user_path(user)
      follow_redirect!
      delete logout_path
      follow_redirect!
      log_in_as user
      assert_redirected_to user_path(user)
    end
  end
end
