module Api::ColorsHelper

  def handle_calculation(method_name, color_type, color)
    color_object = Color.new(color)

    case method_name
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
  end

  def determine_color_type(color)
    color_object = Color.new(color)

    return 'rgb' if color_object.rgb?
    return 'hex' if color_object.hex?

    nil
  end
    
  def complementary
    { color: "##{SecureRandom.hex(3)}" }
  end

  def triadic; end

  def tetradic; end

  def analogous; end

  def split_complementary; end

end
