describe 'sessions management' do
  it 'should get new' do
    get login_path
    assert_response :success
  end
end
