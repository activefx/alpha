class LogRequestID
  def initialize(app); @app = app; end

  def call(env)
    puts "request_id=#{env['HTTP_HEROKU_REQUEST_ID']}"
    @app.call(env)
  end
end
