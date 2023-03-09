source 'https://rubygems.org'

ruby '2.5.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'

gem 'devise'

gem 'friendly_id'

gem "pry"

gem "rubocop"

group :development do
  gem 'sqlite3', '~> 1.3.13'
  gem 'guard-rspec', require: false
  gem 'annotate'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'better_errors'
  gem 'binding_of_caller' # for advanced features of better_errors (repl)
  gem 'erb2haml'
end

group :production do
  gem "pg", "~> 0.18"
  gem 'thin'
end

gem 'exception_notification', '~> 4.2.2'

gem 'carrierwave'
gem 'carrierwave-bombshelter'

# Use for image crop and resize
gem "mini_magick", "~> 4.9.4"

gem 'emoji'

gem 'country_select'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Compass to supercharge SCSS
gem "compass", "~> 0.12.2"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Some Modernizr goodness
gem "modernizr-rails", "~> 2.6.2.3"

# get coordinates from adress
gem 'geocoder'

# more icons!
gem "font-awesome-rails"

# for markup!
gem 'redcarpet'
gem 'md_emoji'

# for pagination
gem 'will_paginate'

# for haml
gem 'haml'

#use rails autolink for fields to automatically display URLs as hyperlinks
gem 'rails_autolink'

gem 'omniauth-github'

gem 'leaflet-rails'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails', '>= 3.8.2'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', require: false
  gem 'pry-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'minitest'
  gem 'rspec-its', '~> 1.0.1'
  gem 'timecop'
  gem 'rails-controller-testing'
end

group :test do
  gem 'vcr'
  gem 'webmock'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
