require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  include AuthHelper

  describe 'JWT Authentication' do
    context 'with a valid JWT token' do
      it 'returns a successful response' do
        headers = { 'Authorization' => auth_headers }
        get '/api/colors/complementary', headers: headers, params: { color: '#78a812' }
        expect(response.status).to eq(200)
      end
    end

    context 'without a JWT token' do
      it 'returns an unauthorized response' do
        get '/api/colors/complementary', params: { color: '#78a812' }
        expect(response.status).to eq(401)
      end
    end

    context 'with an invalid JWT token' do
      it 'returns an unauthorized response' do
        headers = { 'Authorization' => 'Bearer invalid_token' }
        get '/api/colors/complementary', headers: headers, params: { color: '#78a812' }
        expect(response.status).to eq(401)
      end
    end
  end
end