require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

source 'http://rubygems.org'

gem 'rails', '~> 3.2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# General
gem 'multi_json'
gem 'configatron'

# Database
gem 'mongoid', '~> 2.4'
gem 'bson_ext', '~> 1.5'

# Authentication / Authorization
gem 'devise', '~> 2.0'
gem 'omniauth', '~> 1.0', :git => 'git://github.com/intridea/omniauth.git'
gem 'omniauth-oauth', :git => 'git://github.com/intridea/omniauth-oauth.git'
gem 'omniauth-oauth2', :git => 'git://github.com/intridea/omniauth-oauth2.git'
gem 'omniauth-openid', :git => 'git://github.com/intridea/omniauth-openid.git'
gem 'omniauth-facebook', :git => 'git://github.com/mkdynamic/omniauth-facebook.git'
gem 'omniauth-github', :git => 'git://github.com/intridea/omniauth-github.git'
gem 'omniauth-linkedin', :git => 'git://github.com/skorks/omniauth-linkedin.git'
gem 'omniauth-twitter', :git => 'git://github.com/arunagw/omniauth-twitter.git'

# Views
gem 'kaminari'
gem 'haml'
gem 'haml-rails'
# Bootstrap generators was used to set up scaffold, simple form and layouts
# but commented out to allow twitter-bootstrap-rails to serve the Twitter Bootstrap
# assets and avoid any conflicts
# gem 'bootstrap-generators', '~> 2.0', :git => 'git://github.com/decioferreira/bootstrap-generators.git'
gem 'show_for'
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'twitter_bootstrap_form_for', :git => 'git://github.com/stouset/twitter_bootstrap_form_for.git'

# Javascript
gem 'jquery-rails'
# gem 'rails-backbone'

# Utilities
gem 'capistrano'
gem 'thin'
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
  gem 'sass-rails','~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'
  gem 'uglifier'
  gem 'yui-compressor'
  gem 'twitter-bootstrap-rails', :git => 'http://github.com/seyhunak/twitter-bootstrap-rails.git'
end

group :development do
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'letter_opener', :git => 'git://github.com/ryanb/letter_opener.git'
  gem 'rails-footnotes'
end

group :development, :test do
  gem 'simplecov', :require => false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'capybara-mechanize', :git => 'git://github.com/jeroenvandijk/capybara-mechanize.git'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 2.9'
  gem 'rspec-instafail'
  gem 'mocha', :require => false
  gem 'mongoid-rspec', :git => 'git://github.com/evansagge/mongoid-rspec.git'
  gem 'fuubar'
  gem 'database_cleaner'
  # Potential Spork alternative: https://github.com/jstorimer/spin
  gem 'spork-rails'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-coffeescript'
  gem 'guard-jasmine', :git => 'git://github.com/netzpirat/guard-jasmine.git'
  gem 'guard-sass'
  gem 'guard-uglify'
  gem 'guard-process'
  gem 'guard-rails-assets'
  gem 'jasminerice', :git => 'git://github.com/bradphelan/jasminerice.git'
  gem 'jasmine'
  gem 'vcr', '~> 2.0', :require => false
  gem 'webmock', :require => false
  gem 'timecop', :require => false
  platforms :ruby do
    gem 'rb-readline'
  end
  case HOST_OS
  when /darwin/i
    gem 'rb-fsevent'
    gem 'growl'
  when /linux/i
    gem 'therubyracer', :require => 'v8'
    gem 'rb-inotify' #, '>= 0.5.1'
    gem 'libnotify' #, '~> 0.1.3'
  when /mswin|windows/i
    gem 'rb-fchange'
    gem 'win32console'
    gem 'rb-notifu'
  end
  gem 'pry', :require => false
  gem 'pry-doc', :require => false
  # Or use ruby-debug
  # gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache'
  # gem 'ruby-debug-base19x', '~> 0.11.30.pre4'
  # gem 'ruby-debug19', :require => 'ruby-debug'
end

