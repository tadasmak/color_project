require 'swagger_helper'

RSpec.describe 'api/colors', type: :request do

  path '/api/colors/{method_name}' do
    # You'll want to customize the parameter types...
    parameter name: 'method_name', in: :path, type: :string, description: 'method_name'

    get('show color') do
      response(200, 'successful') do
        let(:method_name) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
