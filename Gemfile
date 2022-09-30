source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 7.0.1'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '~> 1.10.2', require: false
gem 'importmap-rails', '~> 1.0.2'
gem 'jbuilder', '~> 2.11.5'
gem 'pg', '~> 1.3.0'
gem 'puma', '~> 5.6.0'
gem 'redis', '~> 4.5.1'
gem 'sprockets-rails', '~> 3.4.2'
gem 'stimulus-rails', '~> 1.0.2'
gem 'tailwindcss-rails', '~> 2.0.5'
gem 'turbo-rails', '~> 1.0.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :production do
end

group :development, :test do
  gem 'debug', '~> 1.4.0', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 2.19.0'
  gem 'rspec-rails', '~> 5.0.2'
end

group :development do
  gem 'htmlbeautifier', '~> 1.4.1'
  gem 'letter_opener', '~> 1.8.0'
  gem 'rubocop', '~> 1.25.0'
  gem 'solargraph', '~> 0.44.3'
  gem 'web-console', '~> 4.2.0'
end

group :test do
  gem 'axe-core-capybara', '~> 4.4.0'
  gem 'axe-core-rspec', '~> 4.4.0'
  gem 'capybara', '~> 3.36.0'
  gem 'selenium-webdriver', '~> 4.1.0'
  gem 'shoulda-matchers', '~> 5.1.0'
  gem 'webdrivers', '~> 5.0.0'
end
