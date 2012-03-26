# Mixin Factory Girl syntax methods, allowing you to write
#
#   describe User, "#full_name" do
#     subject { create(:user, :first_name => "John", :last_name => "Doe") }
#
#     its(:full_name) { should == "John Doe" }
#   end
#
# see https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md &
# http://robots.thoughtbot.com/post/19162390206/short-explicit-test-setups
#
# Invocation syntax
#   create(:user)
#   build(:user)
#   post :create, user: attributes_for(:user)
#
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

