require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '~> 3.2.8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# General
gem 'multi_json'
gem 'configatron'

# Database
gem 'mongoid', '~> 3.0.0'

# Authentication / Authorization
gem 'devise', '~> 2.1.2'
gem 'omniauth', '~> 1.1.0'
gem 'omniauth-oauth'
gem 'omniauth-oauth2'
gem 'omniauth-openid'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-linkedin'
gem 'omniauth-twitter'

# Views
gem 'kaminari'
gem 'haml'
gem 'haml-rails'
# Bootstrap generators was used to set up scaffold, simple form and layouts
# but commented out to allow compass to serve the Twitter Bootstrap assets
# and avoid any conflicts
# gem 'bootstrap-generators', '~> 2.0', :git => 'git://github.com/decioferreira/bootstrap-generators.git'
gem 'show_for'
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'twitter_bootstrap_form_for', :git => 'git://github.com/stouset/twitter_bootstrap_form_for.git'

# Javascript
gem 'jquery-rails'
# gem 'rails-backbone'

# Utilities
gem 'capistrano'
gem 'unicorn'
gem 'foreman'
gem 'whenever', :require => false
# Use Whoops for error notifications when 3.1 ready
# gem 'whoops', :git => git://github.com/flyingmachine/whoops.git or git://github.com/technekes/whoops.git

# Web Services
# gem 'typhoeus'
# gem 'em-http-request', :git => 'git://github.com/igrigorik/em-http-request.git'
# gem 'em-synchrony', :git => 'git://github.com/igrigorik/em-synchrony.git'

group :production do
  # For heroku:
  # gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'compass_twitter_bootstrap'
  gem 'compass-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'
  gem 'uglifier'
  gem 'yui-compressor'
end

group :development do
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'letter_opener', :git => 'git://github.com/ryanb/letter_opener.git'
  gem 'rails-footnotes'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.11'
  gem 'simplecov', :require => false
  gem 'capybara'
  gem 'capybara-mechanize'
  gem 'poltergeist' # or 'capybara-webkit'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'rspec-instafail'
  gem 'mocha', :require => false
  gem 'mongoid-rspec'
  gem 'rack-test'
  gem 'fuubar'
  gem 'database_cleaner'
  # Potential Spork alternative:
  #   https://github.com/jstorimer/spin
  #   https://github.com/vizjerai/guard-spin
  gem 'spork-rails'
  gem 'listen', '>= 0.4.7'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-coffeescript'
  gem 'jasminerice'
  gem 'jasmine-sinon-rails'
  gem 'guard-jasmine'
  gem 'vcr', '~> 2.0', :require => false
  gem 'webmock', :require => false
  gem 'timecop', :require => false
  gem 'therubyracer', :require => 'v8'
  gem 'rb-readline', :platforms => [ :ruby ]
  gem 'rb-fsevent', :require => HOST_OS =~ /darwin/i ? 'rb-fsevent' : false
  gem 'growl', :require => HOST_OS =~ /darwin/i ? 'growl' : false
  gem 'rb-inotify', :require => HOST_OS =~ /linux/i ? 'rb-inotify' : false
  gem 'libnotify', :require => HOST_OS =~ /linux/i ? 'libnotify' : false
  gem 'pry', :require => false
  gem 'pry-doc', :require => false
  gem 'pry-rails'
  # Or use ruby-debug
  # gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache'
  # gem 'ruby-debug-base19x', '~> 0.11.30.pre4'
  # gem 'ruby-debug19', :require => 'ruby-debug'
end
