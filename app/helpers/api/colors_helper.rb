module Api::ColorsHelper

  def handle_calculation(method_name, color_type, color)
    color_object = Color.new(color)

    hsl_array = color_object.hsl_array

    result = [color]

    calculated_colors = case method_name
    when 'complementary'
      handle_complementary(hsl_array, color_type)
    when 'triadic'
      handle_triadic(hsl_array, color_type)
    when 'tetradic'
      handle_tetradic(hsl_array, color_type)
    when 'analogous'
      handle_analogous(hsl_array, color_type)
    when 'split_complementary'
      handle_split_complementary(hsl_array, color_type)
    when 'monochromatic'
      handle_monochromatic(hsl_array, color_type)
    end

    calculated_colors.each { |c| result.push(c) }
    result
  end
    
  def handle_complementary(hsl_array, color_type)
    color1 = hsl_array.dup
    color1[0] = (color1[0] + 180.0) % 360.0

    [convert_to_color_type(color1, color_type)]
  end

  def handle_triadic(hsl_array, color_type)
    colors = []

    for i in 1..2 do
      color = hsl_array.dup
      color[0] = (color[0] + (120.0 * i)) % 360.0
      colors.push(convert_to_color_type(color, color_type))
    end

    colors
  end

  def handle_tetradic(hsl_array, color_type)
    colors = []

    for i in 1..3 do
      color = hsl_array.dup
      color[0] = (color[0] + (90.0 * i)) % 360.0
      colors.push(convert_to_color_type(color, color_type))
    end

    colors
  end

  def handle_analogous(hsl_array, color_type)
    colors = []

    color1 = hsl_array.dup
    color1[0] = (color1[0] + 30.0) % 360.0
    colors.push(convert_to_color_type(color1, color_type))

    color2 = hsl_array.dup
    color2[0] = (color2[0] - 30.0) % 360.0
    colors.push(convert_to_color_type(color2, color_type))

    colors
  end

  def handle_split_complementary(hsl_array, color_type)
    colors = []

    color1 = hsl_array.dup
    color1[0] = (color1[0] + 180.0) % 360.00

    color2 = color1.dup
    color2[0] = (color2[0] + 30.0) % 360.0
    colors.push(convert_to_color_type(color2, color_type))

    color3 = color1.dup
    color3[0] = (color3[0] - 30.0) % 360.0
    colors.push(convert_to_color_type(color3, color_type))

    colors
  end

  def handle_monochromatic(hsl_array, color_type)
    # TODO: implement monochromatic (there are no exact calculations)
    # after front-end is done
  end

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
