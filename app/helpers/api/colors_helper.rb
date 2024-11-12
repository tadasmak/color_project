module Api::ColorsHelper

  def handle_calculation(method_name, color_type, color)
    color_object = Color.new(color)

    hsl_array = color_object.hsl_array

    result = [color]

    calculated_colors = case method_name
    when 'complementary'
      complementary(hsl_array, color_type)
    when 'triadic'
      triadic(hsl_array, color_type)
    when 'tetradic'
      tetradic(hsl_array, color_type)
    when 'analogous'
      analogous(hsl_array, color_type)
    when 'split_complementary'
      split_complementary(hsl_array, color_type)
    end

    calculated_colors.each { |c| result.push(c) }
    result
  end
    
  def complementary(hsl_array, color_type)
    color1 = hsl_array.dup
    color1[0] = (color1[0] + 180) % 360

    [convert_to_color_type(color1, color_type)]
  end

  def triadic(hsl_array, color_type)
    color1 = hsl_array.dup
    color1[0] = (color1[0] + 120) % 360

    color2 = hsl_array.dup
    color2[0] = (color2[0] + 240) % 360

    colors = []
    colors.push(convert_to_color_type(color1, color_type))
    colors.push(convert_to_color_type(color2, color_type))
  end

  def tetradic; end

  def analogous; end

  def split_complementary; end

  def convert_to_color_type(hsl_array, color_type)
    h, s, l = hsl_array
    color_code = "hsl(#{h}, #{s}%, #{l}%)"

    color_object = Color.new(color_code)

    return color_object.rgb if color_type == 'rgb'
    return color_object.hex if color_type == 'hex'
    
    nil
  end

  def determine_color_type(color)
    color_object = Color.new(color)

    return 'rgb' if color_object.rgb?
    return 'hex' if color_object.hex?

    nil
  end
end
