class ApplicationController < ActionController::API
  before_action :authorize_request

  def authorize_request
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Missing token' }, status: :unauthorized if token.nil?

    decoded = decode_token(token)
    @current_user = decoded[:email] if decoded
  rescue JWT::ExpiredSignature
    render json: { error: 'Token has expired' }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { error: 'Unauthorized due to decoding error' }, status: :unauthorized
  end

  private

  def decode_token(token)
    secret = ENV['SECRET_KEY_BASE']
    decoded = JWT.decode(token, secret, true, algorithm: 'HS256')
    decoded[0].symbolize_keys
  end
end
