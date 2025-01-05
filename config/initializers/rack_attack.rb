class Rack::Attack
  # Throttle requests per IP address (100 requests per hour)
  throttle('req/ip', limit: 3, period: 1.hour) do |req|
    req.ip
  end

  # Custom response for throttled requests
  self.throttled_response = lambda do |env|
    [429, {}, ['Rate limit exceeded']]
  end
end