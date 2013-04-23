require 'rbconfig'

HOST_OS = RbConfig::CONFIG['host_os']

def if_darwin(library)
  HOST_OS =~ /darwin/i ? library : false
end

def if_linux(library)
  HOST_OS =~ /linux/i ? library : false
end

source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', git: 'git://github.com/rails/rails.git', branch: '3-2-stable'

# gem 'alpha-installer', path: '/Users/ms/Dropbox/rails/alpha-installer'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# General
gem 'configatron'
gem 'active_attr'
gem 'secure_headers'

# Database
gem 'mongoid', '~> 3.0.0'
# gem 'mongoid-history'
# gem 'streama'
# gem 'geocoder', git: 'git://github.com/bhammond/geocoder.git'
# gem 'mongoid_geospatial', git: 'git://github.com/kristianmandrup/mongoid_geospatial.git'

# Authentication / Authorization
gem 'devise', '~> 2.2.3'
gem 'omniauth', '~> 1.1.3'
gem 'omniauth-oauth', require: false
gem 'omniauth-oauth2', require: false
gem 'omniauth-openid', require: false
gem 'omniauth-facebook', require: false
gem 'omniauth-github', require: false
gem 'omniauth-linkedin', require: false
gem 'omniauth-twitter', require: false
gem 'cancan'
gem 'rolify'

# Views
gem 'kaminari'
gem 'haml'
gem 'haml-rails'
# Bootstrap generators was used to set up scaffold, simple form and layouts
# but commented out to allow compass to serve the Twitter Bootstrap assets
# and avoid any conflicts
# gem 'bootstrap-generators', '~> 2.0', git: 'git://github.com/decioferreira/bootstrap-generators.git'
gem 'show_for'
gem 'simple_form'
gem 'twitter_bootstrap_form_for', git: 'git://github.com/stouset/twitter_bootstrap_form_for.git', branch: 'bootstrap-2.0'
gem 'slim'

# JSON
gem 'multi_json'
gem 'rabl-rails'
gem 'yajl-ruby', require: 'yajl'
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'

# Javascript
gem 'modernizr-rails'
gem 'jquery-rails'
gem 'ember-rails', git: 'git://github.com/emberjs/ember-rails.git'

# External APIs
gem 'newrelic_rpm'
gem 'hominid'
gem 'mandrill'
gem 'mandrill-rails'
gem 'stripe'
gem 'stripe_event'
gem 'heroku-api', git: 'git://github.com/heroku/heroku.rb.git'
gem 'fog', git: 'git://github.com/fog/fog.git'
gem 'kahana', git: 'git://github.com/activefx/kahana.git' #path: '/Users/ms/Dropbox/rails/kahana'
gem 'em-http-request', :git => 'git://github.com/igrigorik/em-http-request.git'

# Utilities
gem 'hashie'
gem 'stamp'
gem 'rack-timeout'
gem 'unicorn'
gem 'unicorn-worker-killer'
gem 'foreman'
gem 'whenever', require: false
gem 'exceptional'
gem 'chronic'
gem 'sinatra', require: false

# Web services
gem 'faraday'
gem 'faraday_middleware'
gem 'typhoeus'

# Background Jobs
gem 'redis'
gem 'sidekiq'
gem 'kiqstand'
gem 'devise-async', require: false
# gem 'carrierwave_backgrounder'

group :production do
  # For heroku:
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'uglifier'
  gem 'yui-compressor'
  gem 'compass_twitter_bootstrap'
  gem 'font-awesome-rails'
  gem 'compass-rails'
  gem 'asset_sync'
end

group :development do
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'letter_opener'
  gem 'rails-footnotes', require: false
  gem 'rack-livereload'
  gem 'guard-livereload'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.13'
  gem 'simplecov', require: false
  gem 'capybara', '~> 2.0'
  gem 'poltergeist', git: 'git://github.com/brutuscat/poltergeist.git'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'rspec-instafail'
  gem 'mocha', require: false
  gem 'mongoid-rspec'
  gem 'json_spec'
  gem 'rack-test', require: 'rack/test'
  gem 'fuubar'
  gem 'database_cleaner'
  gem 'spork-rails'
  gem 'listen', '>= 0.4.7'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-process'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-coffeescript'
  gem 'jasminerice'
  gem 'jasmine-sinon-rails'
  gem 'guard-jasmine'
  gem 'vcr', '~> 2.0', require: false
  gem 'webmock', '~> 1.9', require: false
  gem 'timecop', require: false
  gem 'fakeredis', require: 'fakeredis/rspec'
  gem 'therubyracer', require: 'v8'
  gem 'rb-readline', platforms: :ruby
  gem 'ruby_gntp' # requires Growl
  gem 'rb-fsevent', require: if_darwin('rb-fsevent')
  gem 'rb-inotify', require: if_linux('rb-inotify')
  gem 'libnotify', require: if_linux('libnotify')
  gem 'pry', '~> 0.9.12pre2'
  gem 'pry-rails'
  gem 'pry-doc', require: false
  # Or use ruby-debug (versions may not be up to date)
  # gem 'linecache19', git: 'git://github.com/mark-moseley/linecache'
  # gem 'ruby-debug-base19x', '~> 0.11.30.pre4'
  # gem 'ruby-debug19', :require => 'ruby-debug'
end












