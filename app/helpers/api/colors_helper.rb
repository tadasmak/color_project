module Api::ColorsHelper

  def handle_calculation(method_name, color_type, color)
    color_object = Color.new(color)

    rgb_array = color_object.rgb_array

    case method_name
    when 'complementary'
      complementary(rgb_array)
    when 'triadic'
      triadic
    when 'tetradic'
      tetradic
    when 'analogous'
      analogous
    when 'split_complementary'
      split_complementary
    end

  end

  def determine_color_type(color)
    color_object = Color.new(color)

    return 'rgb' if color_object.rgb?
    return 'hex' if color_object.hex?

    nil
  end
    
  def complementary(rgb_values)
    r = 255 - rgb_values[:r]
    g = 255 - rgb_values[:g]
    b = 255 - rgb_values[:b]

    {r:, g:, b:}
  end

  def triadic; end

  def tetradic; end

  def analogous; end

  def split_complementary; end

end
