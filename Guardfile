# https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
end

#guard 'rails', :port => 5000, :start_on_start => true, :debugger => true, :timeout => 30 do
#  watch('Gemfile.lock')
#  watch(%r{^(config|lib)/.*})
#end

guard 'sass', :input => 'app/assets/stylesheets', :noop => true

guard 'spork', { :wait => 60,
                 :rspec => true,
                 :cucumber => false,
                 :rspec_env => { 'RAILS_ENV' => 'test', 'DRB' => 'true' },
                 :aggressive_kills => true,
                 :bundler => true
                } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.*\.rb$})
  watch(%r{^config/initializers/.*\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb')
end

guard 'rspec', { :all_after_pass => false,
                 :cli => '--drb --format Fuubar --color',
                 :bundler => true,
                 :version => 2
               } do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec/" }
  # Rails example
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/helpers/.+_spec\.rb$})
  watch(%r{^spec/requests/.+_spec\.rb$})
  watch(%r{^spec/requests/.+/.+_spec\.rb$})
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

guard 'jasmine', :phantomjs_bin => '~/phantomjs/bin/phantomjs' do
  watch(%r{app/assets/javascripts/(.+)\.(js\.coffee|js|coffee)$}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
  watch(%r{spec/javascripts/(.+)_spec\.(js\.coffee|js|coffee)$})  { |m| puts m.inspect; "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$})       { "spec/javascripts" }
end

