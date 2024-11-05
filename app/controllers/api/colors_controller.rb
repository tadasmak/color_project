class Api::ColorsController < ApplicationController
  include Api::ColorsHelper
  # TODO: create an API server to have these APIs:
  # GET /colors/complementary which would return a complementary color combination by param[:color]
  # GET /colors/triadic which would return a triadic color combination by param[:color]
  # GET /colors/tetradic which would return a tetradic color combination by param[:color]
  # GET /colors/analogous which would return a analogous color combination by param[:color]
  # GET /colors/split_complementary which would return a split_complementary color combination by param[:color]

  def show
    method_name = params[:method_name]

    result = case method_name
    when 'complementary'
      complementary
    when 'triadic'
      triadic
    when 'tetradic'
      tetradic
    when 'analogous'
      analogous
    when 'split_complementary'
      split_complementary
    end

    render json: result
  end
end
