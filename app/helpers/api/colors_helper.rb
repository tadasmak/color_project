module Api::ColorsHelper

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
