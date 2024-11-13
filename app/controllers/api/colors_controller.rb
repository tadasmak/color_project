class Api::ColorsController < ApplicationController
  include Api::ColorsHelper

  before_action :validate_color, only: [:complementary, :triadic, :tetradic, :analogous, :split_complementary]

  def complementary
    render json: handle_calculation('complementary', @color_type, @color)
  end

  def triadic
    render json: handle_calculation('triadic', @color_type, @color)
  end

  def tetradic
    render json: handle_calculation('tetradic', @color_type, @color)
  end

  def analogous
    render json: handle_calculation('analogous', @color_type, @color)
  end

  def split_complementary
    render json: handle_calculation('split_complementary', @color_type, @color)
  end

  private

  def validate_color
    @color = params[:color]&.downcase
    @color_type = determine_color_type(@color)

    render status: :bad_request, json: { error: 'Hex or RGB format color required' } unless @color_type
  end
end
