namespace :development do
  desc "Substitute application name for Alpha"
  task :install => :environment do
    Dir["#{Rails.root}/config/**/*"].each do |file|
      File.open(file, 'w') do |f|
        f.puts File.read(file).gsub!("Alpha", application_name)
      end
    end
  end

  def application_name
    "NewApp" #Rails.application.class.parent_name
  end
end

