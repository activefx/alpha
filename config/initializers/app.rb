# this file loads first so other initializers have access
require 'configatron'
Configatron::Rails.init

require File.join(Rails.root, "lib", "core_ext.rb")
require File.join(Rails.root, "lib", "simple_form", "label_nested_input.rb")



#auth_config = Quickstartmongo::Application.config.oauth = {}

#auth_config[:facebook] =
#  # facebook does not support multiple domains per key; local dev needs it's own key
#  if Rails.env.production? || Rails.env.staging?
#    # yourdomain.com
#    {consumer_key: '',
#     consumer_secret: ''}
#  else
#    # 0.0.0.0:3000
#    {consumer_key: '',
#     consumer_secret: ''}
#  end

## Manually configure omniauth instead of using devise helpers. Better control and less confusing behind the scenes magic.
#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :facebook, auth_config[:facebook][:consumer_key], auth_config[:facebook][:consumer_secret], scope: 'publish_stream, offline_access, email'
#  # provider :twitter, auth_config[:twitter][:consumer_key], auth_config[:twitter][:consumer_secret]
#  # provider :linked_in, auth_config[:linked_in][:consumer_key], auth_config[:linked_in][:consumer_secret]
#end

