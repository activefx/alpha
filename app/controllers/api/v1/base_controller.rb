# If you are using token authentication with APIs and using trackable.
# Every request will be considered as a new sign in (since there is no
# session in APIs).
#
# You can disable this by creating a before filter as follow:
#   before_filter :skip_trackable
#
#   def skip_trackable
#     request.env['devise.skip_trackable'] = true
#   end

# API Throttling
# http://stackoverflow.com/questions/1375501/how-do-i-throttle-my-sites-api-users
