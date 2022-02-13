describe 'static pages' do
  before :example do
    @base_title = 'LinkedList'
  end

  it 'should get home' do
    get root_path
    assert_response :success
    assert_select 'title', @base_title
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
