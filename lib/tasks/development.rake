namespace :development do

  desc "Rename Alpha application based on current folder name"
  task :install => :environment do
    replace_application_names
    generate_new_app_secret
  end

  def generate_new_app_secret
    new_secret_token = SecureRandom.hex(64)
    file = "#{Rails.root}/config/initializers/secret_token.rb"
    updated_file = File.read(file).
      gsub(/\w{128}/, new_secret_token)
    update_file(file, updated_file)
  end

  def replace_application_names
    application_name_files.each do |file|
      updated_file = File.read(file).
        gsub("Alpha", application_class_name).
        gsub("alpha", application_name)
      update_file(file, updated_file)
    end
  end

  def update_file(old_file, new_file)
    File.open(old_file, 'w') do |f|
      f.write new_file
    end
  end

  def application_class_name
    application_name.classify
  end

  # Name the app after the name of the containing folder
  def application_name
    Rails.root.to_s.split('/').last.underscore
  end

  def application_name_files
    Dir["#{Rails.root}/config/**/*.rb"] +
    Dir["#{Rails.root}/app/views/layouts/*.haml"] +
    Dir["#{Rails.root}/app/views/layouts/partials/*.haml"] +
    Dir["#{Rails.root}/app/views/welcome/*.haml"] +
    [ "#{Rails.root}/Rakefile",
      "#{Rails.root}/config.ru",
      "#{Rails.root}/config/mongoid.yml",
      "#{Rails.root}/lib/api_constraints.rb" ]
  end
end

