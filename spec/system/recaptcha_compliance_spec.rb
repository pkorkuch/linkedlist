require 'rails_helper'

describe 'recaptcha compliance' do
  it 'shows the required terms and privacy notice on the signup form' do
    visit signup_path
    expect(page).to have_content('This site is protected by reCAPTCHA and the Google Privacy Policy and Google Terms of Service apply.')
    expect(page).to have_link('Google Privacy Policy', href: 'https://policies.google.com/privacy')
    expect(page).to have_link('Google Terms of Service', href: 'https://policies.google.com/terms')
  end

  it 'shows the required terms and privacy notice on the login form' do
    visit login_path
    expect(page).to have_content('This site is protected by reCAPTCHA and the Google Privacy Policy and Google Terms of Service apply.')
    expect(page).to have_link('Google Privacy Policy', href: 'https://policies.google.com/privacy')
    expect(page).to have_link('Google Terms of Service', href: 'https://policies.google.com/terms')
  end
end
