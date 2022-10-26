source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0'

gem 'rails', '~> 7.0'

gem 'bcrypt', '~> 3.1'
gem 'bootsnap', '~> 1.10', require: false
gem 'importmap-rails', '~> 1.0'
gem 'jbuilder', '~> 2.11'
gem 'pg', '~> 1.3'
gem 'puma', '~> 5.6'
gem 'redis', '~> 4.5'
gem 'sprockets-rails', '~> 3.4'
gem 'stimulus-rails', '~> 1.0'
gem 'tailwindcss-rails', '~> 2.0'
gem 'turbo-rails', '~> 1.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :production do
end

group :development, :test do
  gem 'debug', '~> 1.4', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.19'
  gem 'rspec-rails', '~> 5.0'
end

group :development do
  gem 'htmlbeautifier', '~> 1.4'
  gem 'letter_opener', '~> 1.8'
  gem 'rubocop', '~> 1.25'
  gem 'solargraph', '~> 0.44'
  gem 'web-console', '~> 4.2'
end

group :test do
  gem 'axe-core-capybara', '~> 4.4'
  gem 'axe-core-rspec', '~> 4.4'
  gem 'capybara', '~> 3.36'
  gem 'selenium-webdriver', '~> 4.1'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'webdrivers', '~> 5.0'
end
