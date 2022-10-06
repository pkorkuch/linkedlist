describe 'Users management' do
  it 'should get new' do
    get signup_path
    assert_response :success
  end

  it 'should redirect index when not logged in' do
    get users_path
    assert_not flash.empty?
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 1
  end

  it 'should redirect edit when not logged in' do
    user = create(:user)
    get edit_user_path(user)
    assert_not flash.empty?
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 1
  end

  it 'should redirect edit when logged in as wrong user' do
    user = create(:user, :activated)
    other_user = create(:user, :activated)
    log_in_as(other_user)
    get edit_user_path(user)
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_redirected_to user_url(other_user)
    follow_redirect!
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 1
  end

  it 'should redirect update when not logged in' do
    user = create(:user)
    patch user_path(user), params: { user: { name: user.name,
                                             email: user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 1
  end

  it 'should redirect update when logged as wrong user' do
    user = create(:user, :activated)
    other_user = create(:user, :activated)
    log_in_as(other_user)
    patch user_path(user), params: { user: { name: user.name,
                                             email: user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_redirected_to user_url(other_user)
    follow_redirect!
    assert_select 'div[role="alert"]', count: 1
    assert_select 'div[role="alert"] li', count: 1
  end

  it 'should not allow changing of the admin attribute' do
    user = create(:user)
    log_in_as(user)
    assert_not user.admin?
    patch user_path(user), params: { user: { password: 'password',
                                             password_confirmation: 'password',
                                             admin: true } }
    assert_not user.reload.admin?
  end

  it 'should redirect destroy when not logged in' do
    user = create(:user)
    assert_no_difference 'User.count' do
      delete user_path(user)
    end
    assert_redirected_to login_url
  end

  it 'should redirect destroy when logged in as a non-admin' do
    user = create(:user, :activated)
    log_in_as user
    assert_no_difference 'User.count' do
      delete user_path(user)
    end
    assert_redirected_to root_url
  end

  it 'should destroy user when logged in as an admin' do
    user = create(:user, :activated)
    admin = create(:user, :activated, :admin)
    log_in_as admin
    assert_difference 'User.count', -1 do
      delete user_path(user)
    end
    expect(User.find_by(id: user.id)).to be_nil
    assert_redirected_to users_url
  end
end
