require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# General
gem 'multi_json'
gem 'configatron'

# Database
gem 'mongoid', '~> 2.3'
gem 'bson_ext', '~> 1.4'
# Useful Mongoid Add-ons
# gem 'geocoder'
# gem 'mongoid_spacial'
# gem 'mongoid-mapreduce'
# https://github.com/tristan622/mongoid-message

# Authentication / Authorization
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'
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
gem 'sass'
gem 'show_for'
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'twitter-bootstrap-rails', :git => 'http://github.com/seyhunak/twitter-bootstrap-rails.git', :branch => 'static'
gem 'twitter_bootstrap_form_for', :git => 'git://github.com/stouset/twitter_bootstrap_form_for.git'

# Javascript
if HOST_OS =~ /linux/i
  gem 'therubyracer', :require => 'v8'
end
gem 'jquery-rails'
# gem 'rails-backbone'

# Utilities
gem 'whenever', :require => false
# Use Whoops for error notifications when 3.1 ready
# gem 'whoops', :git => git://github.com/flyingmachine/whoops.git or git://github.com/technekes/whoops.git

group :production do
  #gem 'therubyracer-heroku'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'compass', :git => 'https://github.com/chriseppstein/compass.git'
  gem 'sass-rails', '  ~> 3.1'
  gem 'coffee-rails', '~> 3.1'
  gem 'uglifier'
  gem 'yui-compressor'
end

group :development do
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'letter_opener', :git => 'git://github.com/ryanb/letter_opener.git'
  gem 'rails-footnotes'
  gem 'bootstrap-generators', :git => 'git://github.com/decioferreira/bootstrap-generators.git'
end

group :development, :test do
  gem 'simplecov', :require => false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'capybara-mechanize', :git => 'git://github.com/jeroenvandijk/capybara-mechanize.git'
  gem 'launchy'
  gem 'factory_girl_rails', '~> 1.3'
  gem 'rspec-rails', '~> 2.6'
  gem 'rspec-instafail'
  gem 'mongoid-rspec', :git => 'git://github.com/evansagge/mongoid-rspec.git'
  gem 'fuubar'
  gem 'database_cleaner'
  # Potential Spork alternative: https://github.com/jstorimer/spin
  gem 'spork', '>= 0.9.0.rc9'
  gem 'jasmine'
  #gem 'jasminerice', :git => 'git://github.com/bradphelan/jasminerice.git'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-coffeescript'
  #gem 'guard-jasmine', :git => 'git://github.com/netzpirat/guard-jasmine.git'
  gem 'guard-jasmine-headless-webkit' #, :git => 'git://github.com/johnbintz/guard-jasmine-headless-webkit.git'
  gem 'guard-sass'
  gem 'guard-uglify'
  gem 'guard-process'
  gem 'guard-rails-assets' #, :git => 'git://github.com/dnagir/guard-rails-assets.git'
  #gem 'guard-rails-assets', :git => 'git://github.com/mcolyer/guard-rails-assets.git', :branch => 'patch-1', :ref => '73d35d98de3b4c1f510ed666f9a16c869c2567c6'
  gem 'jasmine-headless-webkit'
  gem 'vcr', '~> 2.0.0.beta1'
  gem 'webmock', :require => false
  case HOST_OS
  when /darwin/i
    gem 'rb-fsevent'
    gem 'growl'
  when /linux/i
    gem 'rb-inotify' #, '>= 0.5.1'
    gem 'libnotify' #, '~> 0.1.3'
  when /mswin|windows/i
    gem 'rb-fchange'
    gem 'win32console'
    gem 'rb-notifu'
  end
  gem 'ruby-debug19', :require => 'ruby-debug'
end

# Deployment
gem 'capistrano'

