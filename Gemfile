source 'https://rubygems.org'

gem 'devise'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use sqlite3 as the database for Active Record

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
end

group :production do
  gem 'pg'
  gem 'shelly-dependencies'
end

gem 'carrierwave'
# Use for image crop and resize
gem "mini_magick", "~> 3.7.0"

gem 'emoji', '~> 1.0.1'

gem 'country_select', github: 'stefanpenner/country_select'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
# Use Compass to supercharge SCSS
gem "compass", "~> 0.12.2"
# Use Twitter's finest Bootstap, for SCSS of course
gem "bootstrap-sass", '~> 3.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Some Modernizr goodness
gem "modernizr-rails", "~> 2.6.2.3"

#use osm maps
gem 'leaflet-rails', '~> 0.7'

# get coordinates from adress
gem 'geocoder'

# more icons!
gem "font-awesome-rails"

# for markup!
gem 'redcarpet'
gem 'md_emoji'

# for pagination
gem 'will_paginate'

# for admins
gem 'rolify'

# for haml
gem 'haml'

#use rails autolink for fields to automatically display URLs as hyperlinks
gem 'rails_autolink'

gem 'omniauth-github'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', require: false
  gem 'pry-rails'
  gem 'capybara', '2.3.0'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'minitest'
  gem 'rspec-its', '~> 1.0.1'
  gem 'timecop'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
