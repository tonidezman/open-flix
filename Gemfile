source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.0'

gem 'rails', '~> 5.1.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'haml-rails'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'bcrypt', '~> 3.1', '>= 3.1.11'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "bootstrap_form", "~> 2.7"
gem 'faker'
gem 'factory_bot_rails'
gem 'sentry-raven'
gem 'carrierwave'
gem 'mini_magick'
gem 'carrierwave-aws'
gem 'stripe'
gem 'stripe_event'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'rspec-rails'
  gem 'capybara', '~> 2.13'
  gem 'capybara-email'
  gem 'selenium-webdriver'
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-rspec', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'vcr'
end
