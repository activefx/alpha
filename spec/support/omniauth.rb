RSpec.configure do |config|
  config.before(:each, :omniauth) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:default] = {
      :provider => "omniauth",
      :uid => "000000",
      :credentials => {
        :token => "ABCDEF",
        :secret => "123456"
      }
    }
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

# https://github.com/mkdynamic/omniauth-facebook
def stub_facebook
  OmniAuth.config.mock_auth[:facebook] = {
    "provider" => "facebook",
    "uid" => "111111",
    "info" => {
      "nickname" => "jbloggs",
      "email" => "joe@bloggs.com",
      "name" => "Joe Bloggs",
      "first_name" => "Joe",
      "last_name" => "Bloggs",
      "image" => "http://graph.facebook.com/1234567/picture?type=square",
      "urls" => {
        "Facebook" => "http://www.facebook.com/jbloggs"
      },
      "location" => "Palo Alto, California"
    },
    "credentials" => {
      "token" => "ABCDEF", # OAuth 2.0 access_token, which you may wish to store
      "expires_at" => 1321747205, # when the access token expires (if it expires)
      "expires" => false # if you request `offline_access` this will be false
    },
    "extra" => {
      "raw_info" => {
        "id" => "111111",
        "name" => "Joe Bloggs",
        "first_name" => "Joe",
        "last_name" => "Bloggs",
        "link" => "http://www.facebook.com/jbloggs",
        "username" => "jbloggs",
        "location" => {
          "id" => "123456789",
          "name" => "Palo Alto, California"
        },
        "gender" => "male",
        "email" => "joe@bloggs.com",
        "timezone" => -8,
        "locale" => "en_US",
        "verified" => true,
        "updated_time" => "2011-11-11T06:21:03+0000"
      }
    }
  }
end

def stub_linked_in
  OmniAuth.config.mock_auth[:linkedin] = {
    "provider" => "linkedin",
    "uid" => "D9CZBaecKW",
    "credentials" => {
      "token" => "aa431794-0ecf-3eb0-54c2-8a1c3a53bed1",
      "secret" => "a3d6aa31-e082-4fee-97a7-49dda7c2dffa"
    },
    "raw_info" => {
      "firstName" => "John",
      "headline" => "Linkedin User Headline",
      "id" => "D9CZBaecKW",
      "industry"=>"Renewables & Environment",
      "lastName"=>"Doe",
      "publicProfileUrl"=>"http://www.linkedin.com/in/johndoe"
    },
    "info" => {
      "first_name" => "John",
      "headline" => "Linkedin User Headline",
      "image" => nil,
      "industry" => "Renewables & Environment",
      "last_name" => "Doe",
      "name" => "John Doe",
      "urls" => {
        "public_profile" => "http://www.linkedin.com/in/johndoe"
      }
    },
    "extra" => {
      "access_token" => {
        "token" => "aa431794-0ecf-3eb0-54c2-8a1c3a53bed1",
        "secret" => "a3d6aa31-e082-4fee-97a7-49dda7c2dffa",
        "consumer" => {
          "key" => "tewdec6irote",
          "secret" => "2dAG1E6icxrojCJK"
        }
      }
    }
  }
end

def stub_github
  OmniAuth.config.mock_auth[:github] = {
    "uid" => "333333",
    "provider" => "github",
    "credentials" => {
      "token" => "djshf83458hghasd84t89hf",
      "secret" => "fjkh3485y8hgfj83yfhahlk92"
    },
   "extra" => {
      "user_hash" => {
        "id" => "333333",
        "login" => "githubusername",
        "name" => "John Doe"
      }
    }
  }
end

def stub_twitter
  OmniAuth.config.mock_auth[:twitter] = {
    "uid" => "444444",
    "provider" => "twitter",
    "info" => {
      "nickname" => "episod",
      "name" => "Taylor Singletary",
      "location" => "San Francisco, CA",
      "image" => "http://a0.twimg.com/profile_images/1258681373/hobolumbo.jpg",
      "description" => "Reality Technician, Developer Advocate at Twitter, hobolumbo",
      "urls" => {
        "Website" => "http://t.co/op3b03h",
        "Twitter" => "http://twitter.com/episod"
      }
    },
    "credentials" => {
      "token" => "444444-Jxq8aYUDRmykzVKrgoLhXSq67TEa5ruc4GJC2rWimw",
      "secret" => "J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA"
    },
    "extra" => {
      "access_token" => "oauth_token=444444-Jxq8aYUDRmykzVKrgoLhXSq67TEa5ruc4GJC2rWimw&oauth_token_secret=J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA&user_id=444444&screen_name=episod"
    }
  }
end

def stub_google
  OmniAuth.config.mock_auth[:google] = {
    "provider" => "google_oauth2",
    "uid" => "555555",
    "info" => {
      "name" => "John Doe",
      "last_name" => "Doe",
      "email" => "user@example.com",
      "first_name" => "John"
    },
    "credentials" => {
      "expires_at" => "1322540698",
      "expires" => "true",
      "token" => "5eb9c229e1bb9e67547ea36876a175f3",
      "refresh_token" => "aa49c4f3e82ccaa066cafe810e45736f"
    },
    "extra" => {
      "raw_info" => {
        "name" => "John Doe",
        "gender" => "male",
        "id" => "555555",
        "family_name" => "Doe",
        "verified_email" => "true",
        "given_name" => "John",
        "email" => "user@example.com"
      }
    }
  }
end

def stub_yahoo
  OmniAuth.config.mock_auth[:yahoo] = {
    "provider" => "open_id",
    "uid" => "https://me.yahoo.com/a/26b10643144ac33a6639eb4bb966bb8a",
    "info" => {
      "name" => "John Doe",
      "nickname" => "John",
      "email" => "johndoe@yahoo.com"
    },
    "extra" => {
      "response" => {
        "endpoint" => {
          "claimed_id" => "https://me.yahoo.com/a/26b10643144ac33a6639eb4bb966bb8a",
          "server_url" => "https://open.login.yahooapis.com/openid/op/auth"
        },
        "identity_url" => "https://me.yahoo.com/a/26b10643144ac33a6639eb4bb966bb8a"
      }
    }
  }
end

