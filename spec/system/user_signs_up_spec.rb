require 'rails_helper'

describe 'User signup' do
  it 'signs up the user in an unactivated state' do
    user = build(:user)
    visit signup_path
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    fill_in 'Confirm password', with: 'password'
    click_button 'Create account'
    expect(page).to have_content 'Successfully signed up'
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    expect(page).to have_content 'User is not activated'
    expect(page).to have_link 'Log In'
  end
end
