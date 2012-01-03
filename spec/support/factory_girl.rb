# Mixin Factory Girl syntax methods, allowing you to write
#
#   describe User, "#full_name" do
#     subject { create(:user, :first_name => "John", :last_name => "Doe") }
#
#     its(:full_name) { should == "John Doe" }
#   end
#
# see https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
RSpec.configure do |config|
  config.include Factory::Syntax::Methods
end

