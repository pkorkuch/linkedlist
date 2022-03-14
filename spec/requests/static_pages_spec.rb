describe 'static pages' do
  before :example do
    @base_title = 'LinkedList'
  end

  context 'logged in' do
    it 'redirects root to profile of current user' do
      user = create(:user)
      log_in_as user
      get root_path
      assert_redirected_to user_url(user)
    end
  end

  context 'not logged in' do
    it 'redirects root to login page' do
      get root_path
      assert_redirected_to login_url
    end
  end

  it 'should get about' do
    get about_path
    assert_response :success
    assert_select 'title', "About | #{@base_title}"
  end

  it 'should get contact' do
    get contact_path
    assert_response :success
    assert_select 'title', "Contact | #{@base_title}"
  end

  it 'should get help' do
    get help_path
    assert_response :success
    assert_select 'title', "Help | #{@base_title}"
  end
end
