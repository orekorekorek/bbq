source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

gem 'aws-sdk-s3', require: false
gem 'bootsnap', require: false
gem 'bootstrap-icons-helper'
gem 'carrierwave'
gem 'cssbundling-rails'
gem 'devise'
gem 'devise-i18n'
gem 'image_processing', '~> 1.0'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'puma', '~> 5.0'
gem 'rails-i18n'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end
