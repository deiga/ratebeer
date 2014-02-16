source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'
ruby '2.0.0'

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
gem 'jbuilder', '~>2.0' #'~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development do
  gem 'bullet'
  gem 'sextant' # see routes at /rails/routes
  gem 'traceroute'
  gem 'brakeman', :require => false
  gem 'meta_request' # Binding with RailsPanel in chrome
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec'
  gem 'guard-bundler'
end

gem 'pry-rails'
gem 'pry-plus'
gem 'pry-byebug'

gem "slim-rails"
gem 'bcrypt-ruby', '~> 3.1.2'

gem 'therubyracer', platforms: :ruby # or any other runtime
gem 'less-rails'
gem 'autoprefixer-rails'
gem 'semantic-ui-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'sqlite3'
  gem 'guard-migrate'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'webmock'
  gem 'database_cleaner'
end

group :production do
   gem 'pg'
   gem 'rails_12factor'
end

gem 'httparty'
gem 'figaro'
gem 'geocoder'
