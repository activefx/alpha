#class OauthProvider::Provider
#  class << self
#    def provider_class(provider_type)
#      return "OauthProvider::Provider::#{provider_type.classify}".constantize
#    end

#    def normalize_oauth(oauth)
#      {
#        provider_type: oauth['provider'],
#        uid: oauth['uid'],
#        username: oauth['extra'].try(:[], 'user_hash').try(:[], 'screen_name'),
#        gender: oauth['extra'].try(:[], 'user_hash').try(:[], 'gender'),
#        nickname: oauth['user_info']['nickname'],
#        email: oauth['user_info']['email'],
#        name: oauth['user_info']['name'],
#        first_name: oauth['user_info']['first_name'],
#        last_name: oauth['user_info']['last_name'],
#        image_url: oauth['user_info']['image'],
#        location_name: oauth['user_info']['location'],
#        token: oauth['credentials']['token'],
#        secret: oauth['credentials']['secret'],
#        expires: nil,
#        verified: oauth['extra'].try(:[], 'user_hash').try(:[], 'verified'),
#        profile_url: oauth['user_info'].try(:[], 'urls').try(:[], oauth['provider'].camelize),
#        bio: oauth['user_info'].try(:[], 'description')
#      }
#    end
#  end
#end

