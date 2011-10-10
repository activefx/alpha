require 'rubygems'

def start_simplecov
  require 'simplecov'
  SimpleCov.start 'rails' unless ENV["SKIP_COV"]
end

def spork?
  defined?(Spork) && Spork.using_spork?
end

def setup_environment
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'

  start_simplecov unless spork?

  if spork?
    ENV['DRB'] = 'true'
    require "rails/mongoid"
    Spork.trap_class_method(Rails::Mongoid, :load_models)
    Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  end

  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'capybara/rspec'

  require 'factory_girl'
  FactoryGirl.find_definitions

  # require 'macros'

  Rails.backtrace_cleaner.remove_silencers!

  require 'database_cleaner'

  DatabaseCleaner.orm = "mongoid"
  DatabaseCleaner.strategy = :truncation


  RSpec.configure do |config|

    config.mock_with :rspec

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.clean
    end

    config.include Mongoid::Matchers
    config.include Devise::TestHelpers, :type => :controller
  end

  Capybara.javascript_driver = :webkit
end

def each_run
  if spork?
    ActiveSupport::Dependencies.clear
    FactoryGirl.reload
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
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

