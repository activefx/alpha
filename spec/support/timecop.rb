RSpec.configure do |config|
  config.around(:each, :timecop) do |example|
    Timecop.travel(Time.local(2012, 2, 10, 12, 0, 0)) { example.call }
  end
end

