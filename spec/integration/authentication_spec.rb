require 'swagger_helper'

describe 'api/login', type: :request do
  path '/api/login' do
    post('Log in to get authentication JWT Token') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      security []
      
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response(200, 'successful') do
        description 'Returns a bearer JWT token upon successful authentication'
        schema type: :object,
              properties: {
                token: { type: :string, example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...' }
              },
              required: ['token']

        let(:body) { { email: ENV['APP_USER'], password: ENV['APP_PASSWORD'] } }

        run_test! do |response|
          response = JSON.parse(response.body)
          expect(response.keys).to eq(['token'])
          expect(response['token']).not_to be_nil
        end
      end

      response(400, 'no credentials') do
        schema type: :object, properties: { error: { type: :string } }, required: ['error']

        run_test!
      end

      response(401, 'invalid credentials') do
        schema type: :object, properties: { error: { type: :string } }, required: ['error']
      
        let(:body) { { email: 'invalid_email', password: 'invalid_password' } }

        run_test!
      end
    end
  end
end