source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.6'

gem 'pg', '~> 0.21'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 2.3.0', group: :doc

gem 'haml-rails', ">= 2.0.1"
gem 'bootstrap-sass', '>= 3.4.1'
gem 'simple_form'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'puma'

gem 'devise'
gem 'devise-i18n'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'nokogiri', '~> 1.13'

gem 'best_in_place', '~> 3.0.1'

gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'factory_bot_rails'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.1'
  gem 'faker', '~> 1.6', '>= 1.6.1'
end

group :development do
  gem 'annotate'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
    gem 'capistrano',         require: false
    gem 'capistrano-rbenv',     require: false
    gem 'capistrano-rails',   require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano3-puma',   require: false
end
