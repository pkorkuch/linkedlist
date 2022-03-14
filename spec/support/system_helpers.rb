module SystemHelpers
  def log_in_with(user, password: 'password', remember_me: '1')
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    expect(page).to have_content user.name
  end
end

RSpec.configure do |config|
  config.include SystemHelpers, type: :system
end
