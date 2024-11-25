module AuthHelper
  def generate_jwt_token
    payload = { email: ENV['APP_USER'] }
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
  end

  def auth_headers
    "Bearer #{generate_jwt_token}"
  end
end

RSpec.configure do |config|
  config.include AuthHelper
end