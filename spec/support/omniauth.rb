Rspec.configure do |config|
  config.before(:each, :omniauth) do
    OmniAuth.config.test_mode = true
    stub_facebook!
  end
  config.after(:each, :omniauth) do
    OmniAuth.config.test_mode = false
  end
end

def stub_invalid_credentials(provider)
  OmniAuth.config.mock_auth[provider.to_sym] = :invalid_credentials
end

def stub_invalid_response(provider)
  OmniAuth.config.mock_auth[provider.to_sym] = :invalid_response
end

def stub_timeout(provider)
  OmniAuth.config.mock_auth[provider.to_sym] = :timeout
end

#def stub_facebook_invalid_credentials!
#  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
#end

#def stub_facebook_access_denied!
#  OmniAuth.config.mock_auth[:facebook] = :access_denied
#end

def stub_facebook!
  OmniAuth.config.mock_auth[:facebook] = {
    "uid" => '12345',
    "provider" => 'facebook',
    "user_info" => {"nickname" => 'josevalim'},
    "credentials" => {"token" => 'plataformatec'},
    "extra" => {
      "user_hash" => {
        "id" => '12345',
        "link" => 'http://facebook.com/josevalim',
        "email" => 'user456@example.com',
        "first_name" => 'Jose',
        "last_name" => 'Valim',
        "website" => 'http://blog.plataformatec.com.br'
      }
    }
  }
end


#OmniAuth.config.mock_auth[:default] = {
#  "uid" => "1234",
#  "user_info" => {
#    "name" => "No Coverage", "email" => "no_coverage@example.com", "nickname" => "noc"
#  }
#}

#if RSpec.respond_to?(:configure)
#  RSpec.configure do |config|
#    config.before(:all) do
#      @uids = ["abc123", "123456", "xyz789"]
#    end

#    config.after do
#      # because we have a limited number of uids and there's a uniqueness constraint on them, just clear them out each run rather than run into false uniqueness violations
#      Authentication.delete_all
#    end
#  end
#end

def mock_omniauth(user, provider_type)
  if user.is_a?(User)
    username = user.username
    name = user.name
    first_name = user.first_name
    last_name = user.last_name
    nickname = user.nickname
    email = user.email
  else
    user = Factory.attributes_for(:user).symbolize_keys.merge((user || {}).symbolize_keys)
    username = user[:username]
    name = user[:name]
    first_name = user[:first_name]
    last_name = user[:last_name]
    nickname = user[:nickname]
    email = user[:email]
  end

  provider_type = provider_type.underscore
  @uids = @uids = ["abc123", "xyz456", "qrs789"] if @uid.blank?
  uid = @uids.sample
  token = SecureRandom.hex
  secret = SecureRandom.hex

  required = {
    "provider" => provider_type,
    "uid" => uid,
    "credentials" => {
      "token" => token,
      "secret" => secret
    }
  }

  case provider_type
  when "linked_in"
    user_data = {
      "user_info" => {
        "first_name" => first_name,
        "last_name" => last_name,
        "location" => "San Francisco Bay Area",
        "image" => "http://media01.linkedin.com/mpr/mpr/shrink_80_80/p/1/000/06d/2e1/162b903.jpg",
        "description" => "My bio on LinkedIn.",
        "urls" => {
          "Company Website" => "http://example.com/",
          "LinkedIn" => "http://www.linkedin.com/in/john.doe"
        },
        "name" => name
      },
      "extra" => {
        "user_hash" => {
          "screen_name" => username
        }
      }
    }

  when "facebook"
     user_data = {
      "user_info" => {
        "nickname" => username,
        "email" => email,
        "first_name" => first_name,
        "last_name" => last_name,
        "name" => name,
        "image" => "http://graph.facebook.com/534166665/picture?type=square",
        "urls" => {
          "Facebook" => "http://www.facebook.com/john.doe", "Website" => nil
        }
      },
      "extra" => {
        "user_hash" => {
          "id" => "534166665",
          "name" => name,
          "first_name" => first_name,
          "last_name" => last_name,
          "username" => username,
          "link" => "http://www.facebook.com/john.doe",
          "gender" => "male",
          "email" => email,
          "timezone" => -8,
          "locale" => "en_US",
          "verified" => true,
          "updated_time" => "2011-01-06T01:21:05+0000"
        }
      }
    }

  when "twitter"
    user_data = {
      "extra" => {
        "user_hash" => {
          "following" => false,
          "url" => "http://example.com",
          "follow_request_sent" => false,
          "time_zone" => "Eastern Time (US & Canada)",
          "profile_text_color" => "333333",
          "profile_image_url" => "http://a3.twimg.com/profile_images/821736595/photo2_normal.jpg",
          "description" => "This is my Twitter bio.",
          "status" => {
            "favorited" => false,
            "text" => "This is my lastest tweet",
            "retweet_count" => 0,
            "geo" => nil,
            "in_reply_to_screen_name" => nil,
            "in_reply_to_status_id_str" => nil,
            "id_str" => "12345",
            "contributors" => nil,
            "retweeted" => false,
            "source" => "<a href=\"http://twitter.com\" rel=\"nofollow\">Twitter</a>",
            "in_reply_to_user_id_str" => nil,
            "coordinates" => nil,
            "in_reply_to_status_id" => nil,
            "created_at" => "Thu Jan 06 09:42:56 +0000 2011",
            "place" => nil,
            "in_reply_to_user_id" => nil,
            "truncated" => false,
            "id" => 12345
          },
          "friends_count" => 123,
          "profile_sidebar_fill_color" => "DDEEF6",
          "location" => "San Francisco",
          "id_str" => "123",
          "verified" => false,
          "notifications" => false,
          "profile_background_tile" => false,
          "screen_name" => username,
          "listed_count" => 6,
          "created_at" => "Mon Apr 21 04:09:47 +0000 2008",
          "profile_link_color" => "0084B4",
          "contributors_enabled" => false,
          "favourites_count" => 1,
          "profile_sidebar_border_color" => "C0DEED",
          "followers_count" => 345,
          "protected" => false,
          "lang" => "en",
          "profile_use_background_image" => true,
          "name" => name,
          "is_translator" => false,
          "show_all_inline_media" => false,
          "geo_enabled" => true,
          "profile_background_color" => "C0DEED",
          "id" => 123,
          "statuses_count" => 99,
          "profile_background_image_url" => "http://a3.twimg.com/a/1295051201/images/themes/theme1/bg.png",
          "utc_offset" => -18000
        }
      },
      "user_info" => {
        "nickname" => nickname,
        "name" => name,
        "location" => "San Francisco",
        "image" => "http://a3.twimg.com/profile_images/821736595/photo2_normal.jpg",
        "description" => "This is my bio from Twitter.",
        "urls"=> {
          "Website" => "http://example.com",
          "Twitter" => "http://twitter.com/example"
        }
      }
    }
  else
    raise "No matching provider_type for: #{provider_type}"
  end

  oauth_data = user_data.merge(required)
  OmniAuth.config.mock_auth[provider_type.to_sym] = oauth_data

  auth = {
    provider_type: provider_type,
    token: token,
    secret: secret,
    uid: uid,
    username: username,
    nickname: nickname,
    oauth_data_json: oauth_data.to_json
  }
  auth = user.authentications.create!(auth) if user.respond_to?(:persisted?) && user.persisted?

  [user, auth]
end

# https://gist.github.com/853253

# Quickly add a new mock provider
# OmniAuth.config.add_mock(:twitter, {:uid => '12345'})
# This information will automatically be merged with the default info so it will be a valid response
# Default info:
# @mock_auth={:default=>{"uid"=>"1234", "user_info"=>{"name"=>"Bob Example", "email"=>"bob@example.com", "nickname"=>"bob"}}}

#Before('@omniauth') do
#  OmniAuth.config.test_mode = true
#end

#After('@omniauth') do
#  OmniAuth.config.test_mode = false
#end

#def stub_twitter!
#  OmniAuth.config.mock_auth[:twitter] = {
#    'uid' => '819797',
#    'provider' => 'twitter',
#    'user_info' => {
#      'nickname' => 'episod',
#      'name' => 'Taylor Singletary',
#      'location' => 'San Francisco, CA',
#      'image' => 'http://a0.twimg.com/profile_images/1258681373/hobolumbo.jpg',
#      'description' => 'Reality Technician, Developer Advocate at Twitter, hobolumbo',
#      'urls' => {
#        'Website' => 'http://t.co/op3b03h',
#        'Twitter' => 'http://twitter.com/episod'
#      }
#    },
#    'credentials' => {
#      'token' => '819797-Jxq8aYUDRmykzVKrgoLhXSq67TEa5ruc4GJC2rWimw',
#      'secret' => 'J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA'
#    },
#    'extra' => {
#      'access_token' => 'oauth_token=819797-Jxq8aYUDRmykzVKrgoLhXSq67TEa5ruc4GJC2rWimw&oauth_token_secret=J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA&user_id=819797&screen_name=episod'
#    }
#  }
#end

#def stub_facebook!
#  OmniAuth.config.mock_auth[:facebook] = {
#    "uid" => '12345',
#    "provider" => 'facebook',
#    "user_info" => {"nickname" => 'josevalim'},
#    "credentials" => {"token" => 'plataformatec'},
#    "extra" => {
#      "user_hash" => {
#        "id" => '12345',
#        "link" => 'http://facebook.com/josevalim',
#        "email" => 'user456@example.com',
#        "first_name" => 'Jose',
#        "last_name" => 'Valim',
#        "website" => 'http://blog.plataformatec.com.br'
#      }
#    }
#  }
#end

#def stub_facebook_invalid_credentials!
#  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
#end

#def stub_facebook_access_denied!
#  OmniAuth.config.mock_auth[:facebook] = :access_denied
#end

#def stub_google_apps!
#  # OmniAuth.config.mock_auth[:google_apps] = { }
#end

