module RequestHelpers

  def login_user(user)
    login_as(user, :scope => :user)
  end

  def manual_user_login(user)
    visit new_user_session_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button I18n.t('devise.sign_in')
  end

  def login_admin(admin)
    login_as(admin, :scope => :admin)
  end

  def logout_user
    logout(:user)
    visit destroy_user_session_path
  end

  def logout_admin
    logout(:admin)
    visit destroy_admin_session_path
  end

  def register(username, password, options = {})
    visit new_user_registration_path
    fill_in "user_email", :with => username
    fill_in "user_password", :with => password
    fill_in "user_password_confirmation", :with => password
    if options[:invite_code]
      fill_in "user_invite_code", :with => options[:invite_code]
    end
    click_button I18n.t('devise.sign_up')
  end

  def invite_code(options = {})
    InviteCode.create(options).token
  end

  def soap
    save_and_open_page
  end

end

#def login_user(user)
#  visit new_user_session_path
#  fill_in "Email", :with => user.email
#  fill_in "Password", :with => user.password
#  click_button "Sign in"
#end

## fill_in_fields :user_email   => 'bob@smith.com'
## fill_in_fields :user, :email => 'bob@smith.com'
#def fill_in_fields *args
#  raise 'Too many arguments!' if args.size > 2
#  prefix = args.first.is_a?(Hash) ? '' : "#{ args.shift }_"
#  args.last.each { |field, value| fill_in "#{ prefix }#{ field }", :with => value }
#end

#def reload_page
#  visit current_path
#end

## Apparently, Rack Test and Capybara don't get along when it comes to cookies.
#def fetch_cookies
#  raise 'unsupported driver, use rack::test' unless Capybara.current_session.driver.is_a?(Capybara::Driver::RackTest)

#  driver   = Capybara.current_session.driver
#  session  = driver.current_session.instance_variable_get '@rack_mock_session'
#  @cookies = session.cookie_jar.instance_variable_get '@cookies'
#end

#def should_be_on path
#  current_path.should == path.split('?').first #ignore query string
#end

#def should_not_be_on path
#  current_path.should_not == path
#end

#def dom_id obj
#  "#{ obj.class.model_name.underscore }_#{ obj.id }".downcase
#end

#def use_javascript
#  Capybara.current_driver = :selenium
#end

RSpec.configure do |config|
  config.include RequestHelpers, :example_group => {
    :file_path => config.escaped_path(%w[spec (requests|integration|features)])
  }
end
