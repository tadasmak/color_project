class Api::AuthenticationController < ApplicationController
  skip_before_action :authorize_api_request, only: [:login]

  def login
    email = params[:email]
    password = params[:password]

    return render json: { error: 'Empty email or password' }, status: :bad_request if email.blank? || password.blank?

    if valid_credentials?(email, password)
      token = generate_token(email:)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  private

  def valid_credentials?(email, password)
    email == ENV['APP_USER'] && password == ENV['APP_PASSWORD']
  end

  def generate_token(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
  end
end
