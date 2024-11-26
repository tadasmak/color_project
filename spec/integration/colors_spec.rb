require 'swagger_helper'

describe 'api/colors', type: :request do
  include AuthHelper

  let(:Authorization) { auth_headers }

  path '/api/colors/complementary' do
    get('Get complementary colors combination') do
      tags 'Color'
      security [bearerAuth: []]

      # Defined required query parameter 'color'
      parameter name: 'color', in: :query, type: :string, required: true,
                description: 'Color value in rgb or hex format (e.g. rgb(120, 240, 15), #78f00f)'

      response(200, 'successful') do
        schema type: :array,
               items: { type: :string, description: 'Complementary colors combination'}
        
        context 'when color is hex format' do
          let(:color) { '#78a812' }
          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['#78a812', '#4212a8'])
          end
        end

        context 'when color is rgb format' do
          let(:color) { 'rgb(100, 71, 228)' }
          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['rgb(100, 71, 228)', 'rgb(199, 228, 71)'])
          end
        end
      end

      response(400, 'invalid parameter') do
        schema type: :object, properties: { error: { type: :string } }, required: ['error']

        let(:color) { 'invalid_color_format' }
        run_test!
      end
    end
  end

  path '/api/colors/triadic' do
    # Defined required query parameter 'color'
    parameter name: 'color', in: :query, type: :string, required: true,
              description: 'Color value in rgb or hex format (e.g. rgb(120, 240, 15), #78f00f)'

    get('Get triadic colors combination') do
      tags 'Color'
      response(200, 'successful') do
        schema type: :array,
               items: { type: :string, description: 'Triadic colors combination'}
        
        context 'when color is hex format' do
          let(:color) { '#78a812' }

          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['#78a812', '#1278a8', '#a81278'])
          end
        end

        context 'when color is rgb format' do
          let(:color) { 'rgb(100, 71, 228)' }
          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['rgb(100, 71, 228)', 'rgb(71, 228, 100)', 'rgb(228, 100, 71)'])
          end
        end
      end

      response(400, 'invalid parameter') do
        schema type: :object, properties: { error: { type: :string } }, required: ['error']

        let(:color) { 'invalid_color_format' }
        run_test!
      end
    end
  end

  path '/api/colors/tetradic' do
    # Defined required query parameter 'color'
    parameter name: 'color', in: :query, type: :string, required: true,
              description: 'Color value in rgb or hex format (e.g. rgb(120, 240, 15), #78f00f)'

    get('Get tetradic colors combination') do
      tags 'Color'
      response(200, 'successful') do
        schema type: :array,
               items: { type: :string, description: 'Tetradic colors combination'}
        
        context 'when color is hex format' do
          let(:color) { '#78a812' }

          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['#78a812', '#12a88d', '#4212a8', '#a8122d'])
          end
        end

        context 'when color is rgb format' do
          let(:color) { 'rgb(100, 71, 228)' }
          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['rgb(100, 71, 228)', 'rgb(228, 71, 120)', 'rgb(199, 228, 71)', 'rgb(71, 228, 178)'])
          end
        end
      end

      response(400, 'invalid parameter') do
        schema type: :object, properties: { error: { type: :string } }, required: ['error']

        let(:color) { 'invalid_color_format' }
        run_test!
      end
    end
  end

  path '/api/colors/analogous' do
    # Defined required query parameter 'color'
    parameter name: 'color', in: :query, type: :string, required: true,
              description: 'Color value in rgb or hex format (e.g. rgb(120, 240, 15), #78f00f)'

    get('Get analogous colors combination') do
      tags 'Color'
      response(200, 'successful') do
        schema type: :array,
               items: { type: :string, description: 'Analogous colors combination'}
        
        context 'when color is hex format' do
          let(:color) { '#78a812' }

          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['#78a812', '#2da812', '#a88d12'])
          end
        end

        context 'when color is rgb format' do
          let(:color) { 'rgb(100, 71, 228)' }
          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['rgb(100, 71, 228)', 'rgb(178, 71, 228)', 'rgb(71, 120, 228)'])
          end
        end
      end

      response(400, 'invalid parameter') do
        schema type: :object, properties: { error: { type: :string } }, required: ['error']

        let(:color) { 'invalid_color_format' }
        run_test!
      end
    end
  end

  path '/api/colors/split_complementary' do
    # Defined required query parameter 'color'
    parameter name: 'color', in: :query, type: :string, required: true,
              description: 'Color value in rgb or hex format (e.g. rgb(120, 240, 15), #78f00f)'

    get('Get split complementary colors combination') do
      tags 'Color'
      response(200, 'successful') do
        schema type: :array,
               items: { type: :string, description: 'Split complementary colors combination'}
        
        context 'when color is hex format' do
          let(:color) { '#78a812' }

          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['#78a812', '#122da8', '#8d12a8'])
          end
        end

        context 'when color is rgb format' do
          let(:color) { 'rgb(100, 71, 228)' }
          run_test! do |response|
            colors = JSON.parse(response.body)
            expect(colors).to match_array(['rgb(100, 71, 228)', 'rgb(120, 228, 71)', 'rgb(228, 178, 71)'])
          end
        end
      end

      response(400, 'invalid parameter') do
        schema type: :object, properties: { error: { type: :string } }, required: ['error']

        let(:color) { 'invalid_color_format' }
        run_test!
      end
    end
  end
end
