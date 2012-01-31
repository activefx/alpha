# TODO: Change name in app layout
# TODO: Change session store and token

namespace :development do
  desc "Substitute application name for Alpha"
  task :install => :environment do
    replace_application_names
  end

  def replace_application_names
    application_name_files.each do |file|
      updated_file = File.read(file).
        gsub("Alpha", application_class_name).
        gsub("alpha", application_name)
      File.open(file, 'w') do |f|
        f.write updated_file
      end
    end
  end

  def application_class_name
    application_name.classify
  end

  # Can't use Rails.application.class.parent_name,
  # if repo is cloned nothing would be changed so
  # we can name the application after the folder
  # it is stored in.
  def application_name
    Rails.root.to_s.split('/').last
  end

  def application_name_files
    Dir["#{Rails.root}/config/**/*.rb"] +
    [ "#{Rails.root}/Rakefile",
      "#{Rails.root}/README",
      "#{Rails.root}/config.ru",
      "#{Rails.root}/config/mongoid.yml" ]
  end
end

