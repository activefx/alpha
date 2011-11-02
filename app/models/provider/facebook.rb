#class OauthProvider::Provider::Facebook < OauthProvider::Provider
#  def self.normalize_oauth(oauth)
#    super(oauth).merge({
#      username: oauth['extra']['user_hash'].try(:[], 'username'),
#      email: oauth['extra']['user_hash']['email'],
#      location_name: oauth['extra']['user_hash']['location'].try(:[], 'name'),
#      bio: oauth['extra']['user_hash'].try(:[], 'bio')
#    })
#  end
#end

