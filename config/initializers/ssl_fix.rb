#if Rails.env == "production"
#  require 'openssl'
#  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#end

