class ApplicationController < ActionController::Base
  before_action :authorize_request

  def authorize_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = decode_token(token)
    @current_user = decoded[:email] if decoded
  rescue JWT::ExpiredSignature
    render json: { error: 'Token has expired' }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { error: 'Unauthorized for some reason' }, status: :unauthorized
  end

  private

  def decode_token(token)
    secret = Rails.application.credentials.secret_key_base
    decoded = JWT.decode(token, secret, true, algorithm: 'HS256')
    decoded[0].symbolize_keys
  end
end
