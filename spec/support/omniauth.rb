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

def stub_twitter!
  OmniAuth.config.mock_auth[:twitter] = {
    'uid' => '819797',
    'provider' => 'twitter',
    'user_info' => {
      'nickname' => 'episod',
      'name' => 'Taylor Singletary',
      'location' => 'San Francisco, CA',
      'image' => 'http://a0.twimg.com/profile_images/1258681373/hobolumbo.jpg',
      'description' => 'Reality Technician, Developer Advocate at Twitter, hobolumbo',
      'urls' => {
        'Website' => 'http://t.co/op3b03h',
        'Twitter' => 'http://twitter.com/episod'
      }
    },
    'credentials' => {
      'token' => '819797-Jxq8aYUDRmykzVKrgoLhXSq67TEa5ruc4GJC2rWimw',
      'secret' => 'J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA'
    },
    'extra' => {
      'access_token' => 'oauth_token=819797-Jxq8aYUDRmykzVKrgoLhXSq67TEa5ruc4GJC2rWimw&oauth_token_secret=J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA&user_id=819797&screen_name=episod'
    }
  }
end

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

def stub_facebook_invalid_credentials!
  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
end

def stub_facebook_access_denied!
  OmniAuth.config.mock_auth[:facebook] = :access_denied
end

def stub_google_apps!
  # OmniAuth.config.mock_auth[:google_apps] = { }
end

