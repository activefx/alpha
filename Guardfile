# https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
end

guard 'sass', :input => 'app/assets/stylesheets', :noop => true

# Make sure this guard is ABOVE any other guards using assets such as jasmine-headless-webkit
# It is recommended to make explicit list of assets in `config/application.rb`
# config.assets.precompile = ['application.js', 'application.css', 'all-ie.css']
#guard 'rails-assets' do
#  watch(%r{^app/assets/.+$})
#  watch('config/application.rb')
#end

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
end

guard 'rspec', :all_after_pass => false, :cli => '--drb --format Fuubar --color', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec/" }

  # Rails example
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec/" }
  watch('spec/spec_helper.rb')                        { "spec/" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
end

guard 'coffeescript', :input => 'app/assets/javascripts', :output => 'public/javascripts'

#JASMINE_HOST = '127.0.0.1'
#JASMINE_PORT = '8888'
#JASMINE_URL = "http://#{JASMINE_HOST}:#{JASMINE_PORT}/jasmine"

#guard 'process', :name => 'Jasmine server', :command => "bundle exec rails s -p #{JASMINE_PORT}" do
#  watch(%r{spec/javascripts/support/*})
#end

#Thread.new do
#  require 'socket'

#  puts "\nWaiting for Jasmine to accept connections on #{JASMINE_URL}..."
#  wait_for_open_connection(JASMINE_HOST, JASMINE_PORT)
#  puts "Jasmine is now ready to accept connections; change a file or press ENTER run your suite."
#  puts "You can also view and run specs by visiting:"
#  puts JASMINE_URL

#  guard 'jasmine', :all_after_pass => false, :jasmine_url => JASMINE_URL, :phantomjs_bin => '/usr/bin/phantomjs' do
#    watch(%r{app/assets/javascripts/(.+)\.(js\.coffee|js)}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
#    watch(%r{spec/javascripts/(.+)_spec\.(js\.coffee|js)})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
#    watch(%r{spec/javascripts/spec\.(js\.coffee|js)})       { "spec/javascripts" }
#    watch(%r{spec/javascripts/support/jasmine\.yml})        { "spec/javascripts" }
#    watch(%r{spec/javascripts/support/jasmine_config\.rb})  { "spec/javascripts" }
#  end
#end

#def wait_for_open_connection(host, port)
#  while true
#    begin
#      TCPSocket.new(host, port).close
#      return
#    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
#    end
#  end
#end

#guard 'jasmine', :all_after_pass => false, :jasmine_url => 'http://localhost:8888/jasmine', :phantomjs_bin => '/usr/bin/phantomjs' do
#  watch(%r{app/assets/javascripts/(.+)\.(js\.coffee|js)}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
#  watch(%r{spec/javascripts/(.+)_spec\.(js\.coffee|js)})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
#  watch(%r{spec/javascripts/spec\.(js\.coffee|js)})       { "spec/javascripts" }
#  watch(%r{spec/javascripts/support/jasmine\.yml})        { "spec/javascripts" }
#  watch(%r{spec/javascripts/support/jasmine_config\.rb})  { "spec/javascripts" }
#end



#guard 'uglify', :destination_file => "public/javascripts/application.js" do
#  watch (%r{app/assets/javascripts/application.js})
#end

