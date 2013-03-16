require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist # or :webkit

# You can customize the way that Capybara sets up Poltegeist via the following code in your test setup:
#
#  Capybara.register_driver :poltergeist do |app|
#    Capybara::Poltergeist::Driver.new(app, options)
#  end
#
# The following options are supported:
#
#  :phantomjs (String) - A custom path to the phantomjs executable
#  :debug (Boolean) - When true, debug output is logged to STDERR
#  :logger (Object responding to puts) - When present, debug output is written to this object
#  :timeout (Numeric) - The number of seconds we'll wait for a response when communicating with PhantomJS. nil means wait forever. Default is 30.
#  :inspector (Boolean, String) - See 'Remote Debugging', above.
#  :js_errors (Boolean) - When false, Javascript errors do not get re-raised in Ruby.
#  :window_size (Array) - The dimensions of the browser window in which to test, expressed as a 2-element array, e.g. [1024, 768]. Default: [1024, 768]
#  :phantomjs_options (Array) - Additional command line options to be passed to PhantomJS, e.g. ['--load-images=no', '--ignore-ssl-errors=yes']
