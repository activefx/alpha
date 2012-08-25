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
    require "rails/application"
    require "rails/mongoid"
    # Mongoid likes to preload all of your models in rails, making Spork
    # a near worthless experience. It can be defeated with this code,
    # in your Spork.prefork block, before loading config/environment.rb
    Spork.trap_class_method(Rails::Mongoid, :load_models)
    # Prevent main application to eager_load in the prefork block
    # (do not load files in autoload_paths)
    Spork.trap_method(Rails::Application, :eager_load!)
    # Devise likes to load your devise models. We want to avoid this.
    # It does so in the routes file, when calling devise_for :users.
    # Trap the the method to delay route loading.
    Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  end

  require File.expand_path("../../config/environment", __FILE__)

  if spork?
    # Load all railties files
    Rails.application.railties.all { |r| r.eager_load! }
  end

  # Don't make pry a requirement to run the test suite
  begin
    require 'pry'
    require 'pry-doc'
  rescue LoadError; end

  require 'rspec/rails'

  require 'mocha'
  require 'timecop'

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
    #config.filter_run :js => true if ENV['JS'] == 'true'
    #config.filter_run :js => nil if ENV['JS'] == 'false'
    config.run_all_when_everything_filtered = true
  end
end

def each_run
  if spork?
    # Start simplecov unless skip env variable set
    # Solution from https://github.com/colszowka/simplecov/issues/42#issuecomment-4440284
    start_simplecov unless ENV["SKIP_COV"]
    Rails.cache.clear
    ActiveSupport::Dependencies.clear
    # When specifying a class for a factory, using a class constant
    # will cause the model to be preloaded in prefork preventing
    # reloading, whereas using a string will not
    #
    # Factory.define :user, class: 'MyUserClass' do |f|
    #   ...
    # end
    #FactoryGirl.reload
    FactoryGirl.factories.clear
    FactoryGirl.find_definitions
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  # Clean the log file before each run
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
