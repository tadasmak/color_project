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

    return render status: :bad_request, json: { error: 'Combination method is not recognized'} unless ['complementary', 'triadic', 'tetradic', 'analogous', 'split_complementary'].include? method_name

    color = params[:color]&.downcase
    color_type = determine_color_type(color)

    return render status: :bad_request, json: { error: 'Hex or RGB format color required' } unless color_type

    result = handle_calculation(method_name, color_type, color)

    render json: result
  end
end
