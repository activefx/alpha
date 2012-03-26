require 'rubygems'

def start_simplecov
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter "/factories/"
  end
end

def spork?
  defined?(Spork) && Spork.using_spork?
end

def setup_environment
  ENV["RAILS_ENV"] ||= 'test'

  start_simplecov unless spork? || ENV["SKIP_COV"]

  if spork?
    ENV['DRB'] = 'true'
    require "rails/mongoid"
    Spork.trap_class_method(Rails::Mongoid, :load_models)
    Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  end

  require File.expand_path("../../config/environment", __FILE__)

  require 'pry'
  require 'pry-doc'

  require 'rspec/rails'

  require 'mocha'
  require 'timecop'

  #require 'em-synchrony'
  #require 'em-synchrony/em-http'
  require 'webmock'
  require 'webmock/rspec'
  require 'vcr'

  require 'capybara/rspec'
  require 'capybara/mechanize'
  Capybara.javascript_driver = :webkit

  Rails.backtrace_cleaner.remove_silencers!

  require 'database_cleaner'

  RSpec.configure do |config|
    config.mock_with :rspec
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end
end

def each_run
  if spork?
    Rails.cache.clear
    ActiveSupport::Dependencies.clear
    # Be sure to load each factory's model before defining
    # the factory to ensure compatibility with Spork
    # ex. load "#{Rails.root}/app/models/user.rb"
    FactoryGirl.reload
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  # Clean the log file
  File.open("#{Rails.root}/log/test.log", 'w') { |file| file.truncate(0) }
end

# If spork is available in the Gemfile it'll be used but we don't force it.
unless (begin; require 'spork'; rescue LoadError; nil end).nil?
  Spork.prefork do
    # Loading more in this block will cause your tests to run faster. However,
    # if you change any configuration or code from libraries loaded here, you'll
    # need to restart spork for it take effect.
    setup_environment
  end

  Spork.each_run do
    # This code will be run each time you run your specs.
    each_run
  end
else
  setup_environment
  each_run
end

