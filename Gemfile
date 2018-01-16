source 'https://rubygems.org'

ruby '2.4.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.8'

gem 'devise'

gem 'friendly_id', '~> 5.1.0'

group :development do
  gem 'sqlite3'
  gem 'guard-rspec', require: false
  gem 'annotate'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'better_errors'
  gem 'binding_of_caller' # for advanced features of better_errors (repl)
  gem 'erb2haml'
  gem 'letter_opener'
end

group :production do
  gem 'pg'
  gem 'thin'
end

gem 'exception_notification'

gem 'carrierwave'
gem 'carrierwave-bombshelter'

# Use for image crop and resize
gem "mini_magick", "~> 3.7.0"

gem 'emoji', '~> 1.0.1'

gem 'country_select', github: 'stefanpenner/country_select'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
# Use Compass to supercharge SCSS
gem "compass", "~> 0.12.2"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

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
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', require: false
  gem 'pry-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'minitest'
  gem 'rspec-its', '~> 1.0.1'
  gem 'timecop'
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
