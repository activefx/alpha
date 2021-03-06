# https://github.com/guard/guard#readme

guard :bundler do
  watch('Gemfile')
end

# guard 'sass', :input => 'app/assets/stylesheets', :noop => true

group :server do

  # guard :process, :name => 'Rails', :command => 'bundle exec foreman start' do
  #   watch('Gemfile.lock')
  #   watch(%r{^(config|lib)/.*})
  # end

end

group :front do

  guard :livereload do
    watch(%r{app/views/.+\.(erb|haml|slim)$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{config/locales/.+\.yml})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
  end

end

scope :dev => [ :server, :front ]

group :specs do

  guard :spork, {
      :wait => 60,
      :rspec => true,
      :cucumber => false,
      :rspec_env => { 'RAILS_ENV' => 'test', 'DRB' => 'true' },
      :aggressive_kill => true,
      :bundler => true,
      :foreman => true
    } do
      watch('config/application.rb')
      watch('config/environment.rb')
      watch(%r{^config/environments/.*\.rb$})
      watch(%r{^config/initializers/.*\.rb$})
      watch('Gemfile')
      watch('Gemfile.lock')
      watch('spec/spec_helper.rb')
  end

  guard :rspec, {
      :all_on_start => false,
      :all_after_pass => false,
      :keep_failed => true,
      :spec_paths => ["spec"],
      :cli => '--drb --format Fuubar --color',
      :bundler => true
    } do
      watch(%r{^spec/.+_spec\.rb$})
      watch(%r{^spec/helpers/.+_spec\.rb$})
      watch(%r{^spec/requests/.+_spec\.rb$})
      watch(%r{^spec/requests/.+/.+_spec\.rb$})
      watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
      watch('spec/spec_helper.rb')  { "spec" }

      # Rails example
      watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
      watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
      watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
      watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
      watch('config/routes.rb')                           { "spec/routing" }
      watch('app/controllers/application_controller.rb')  { "spec/controllers" }

      # Capybara request specs
      watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }

      # Turnip features and steps
      # watch(%r{^spec/acceptance/(.+)\.feature$})
      # watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
  end

end

group :js do

  guard :jasmine, {
      :all_on_start => false,
      :all_after_pass => false,
      :timeout => 30,
      :port => 8080,
      :jasmine_url => 'http://localhost:8080/jasmine'
    } do
      watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$}) { 'spec/javascripts' }
      watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
      watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)(?:\.\w+)*$}) { |m| "spec/javascripts/#{ m[1] }_spec.#{ m[2] }" }
  end

end

scope :test => [ :specs, :js ]


