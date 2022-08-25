source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

gem 'sprockets-rails'

gem 'puma', '~> 5.0'

gem 'jsbundling-rails'

gem 'stimulus-rails'

gem 'cssbundling-rails'

gem 'jbuilder'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false

gem 'turbo-rails'

group :development, :test do
  gem 'sqlite3', '~> 1.4'

  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
