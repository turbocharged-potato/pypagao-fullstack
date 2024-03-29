source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

### BASICS

# Ruby version
ruby '2.5.8'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.5'
# Use postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

### END BASICS

### UTILITIES
# Environment variables
gem 'dotenv-rails', require: 'dotenv/rails-now'
# Mailgun
gem 'mailgun-ruby', '~> 1.1.10'

# Bootstrap
gem 'bootstrap'
# jQuery
gem 'jquery-rails'
# FontAwesome!
gem 'font-awesome-sass', '~> 5.2.0'

# Compress assets!
gem 'heroku-deflater', :group => :production

group :test do
  # Test coverage
  gem 'coveralls', require: false
end

group :development do
  # Generate Entity-Relationship Diagram
  gem 'rails-erd', require: false
  # Annotates model with schema
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Shoot them n+1 queries!
  gem 'bullet'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Rspec testing framework
  gem 'rspec-rails'
  # Factory bot: factories for testing
  gem 'factory_bot_rails'
  # Shoulda Matchers: matchers for testing -- experimental gem for Rails 5
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  # Traceroute
  gem 'traceroute'
end

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

### QUALITY

group :development, :test do
  # Ruby linter
  gem 'rubocop'
  # SCSS linter
  gem 'scss_lint', require: false
end

### MAINTENANCE

group :development do
  # Database profiler
  gem 'rack-mini-profiler'
end

group :production do
  # Auto-email exceptions
  gem 'exception_notification'
end

### SECURITY

gem 'devise'

group :development, :test do
  # Security checkup
  gem 'brakeman'
end
