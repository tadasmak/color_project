module Api::ColorsHelper

  def handle_calculation(method_name, color_type, color)
    color_object = Color.new(color)

    rgb_array = color_object.rgb_array

    result = [color]

    calculated_colors = case method_name
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

    if color_type == 'hex'
      calculated_colors.each do |c|
        result.push(form_hex(c))
      end
    elsif color_type == 'rgb'
      calculated_colors.each do |c|
        result.push(form_rgb(c))
      end
    end

    result
  end

  def determine_color_type(color)
    color_object = Color.new(color)

    return 'rgb' if color_object.rgb?
    return 'hex' if color_object.hex?

    nil
  end

  def form_rgb(rgb_values)
    return "rgb(#{rgb_values[:r]}, #{rgb_values[:g]}, #{rgb_values[:b]})"
  end

  def form_hex(rgb_values)
    return "##{rgb_values[:r].to_s(16)}#{rgb_values[:g].to_s(16)}#{rgb_values[:b].to_s(16)}"
  end
    
  def complementary(rgb_values)
    r = 255 - rgb_values[:r]
    g = 255 - rgb_values[:g]
    b = 255 - rgb_values[:b]

    [{r:, g:, b:}]
  end

  def triadic; end

  def tetradic; end

  def analogous; end

  def split_complementary; end

end
